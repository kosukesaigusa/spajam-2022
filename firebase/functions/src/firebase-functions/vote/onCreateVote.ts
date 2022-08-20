import * as functions from 'firebase-functions'
import { VoteRepository } from '~/src/repositories/vote'
import { Vote } from '~/src/models/vote'
import { sendFCMByUserIds } from '~/src/utils/fcm/sendFCMNotification'
import { VotingEventRepository } from '~/src/repositories/votingEvent'

/**
 * 新しい vote ドキュメントが作成されたときに発火する。
 * - 全員がvoteしたかを確認
 *  - 全員でない場合：
 *      - 何もしない
 *  - 全員終わった場合：
 *      - 算出ロジックを実行
 *      - その返り値でvotingEvent.resultを更新
 *      - votingEvent.votingUserIdsにプッシュ通知を送る (resultも一緒に？)
 *      - 新しいvotingEventドキュメントを作成する
 */
export const onCreateVote = functions
    .region(`asia-northeast1`)
    .firestore.document(`/rooms/{roomId}/votingEvents/{votingEventId}/votes/{voteId}`)
    .onCreate(async (_, context) => {
        functions.logger.info(`あああああ`)
        const { roomId, votingEventId } = context.params
        // votingEventのuserIdsを取得
        const votingEventRepository = new VotingEventRepository()
        const votingEvent = await votingEventRepository.fetchVotingEvent({ roomId, votingEventId })
        if (votingEvent === undefined) {
            functions.logger.error(
                `指定のVotingEventが存在しません: { roomId: ${roomId}, votingEventId: ${votingEventId} }`
            )
            return
        }
        const userIds = votingEvent.votingUserIds
        // votesのドキュメント数を取得
        const voteRepository = new VoteRepository()
        const votes = await voteRepository.fetchVotes({ roomId, votingEventId })
        // 比較
        if (votes.length < userIds.length) {
            functions.logger.info(`まだ全員の回答が終わっていないので終了します。`)
            return
        }
        functions.logger.info(`全員の回答が終わりました、結果を算出します。`)

        // 算出ロジックの実行
        const result = calculateResult(votes)
        functions.logger.info(`算出結果：${result}`)

        try {
            await votingEventRepository.completeVotingEvent({ roomId, votingEventId, result })
        } catch (e) {
            functions.logger.error(`resultの更新に失敗しました: { roomId: ${roomId}, votingEventId: ${votingEventId} }`)
            return
        }

        // votingEvent.votingUserIds にプッシュ通知を送る
        await sendFCMByUserIds({
            userIds: userIds,
            title: `勝敗が決しました`,
            body: `結果画面で勝敗を確認してください`,
            location: `/`
        })

        try {
            // 新しい votingEvent ドキュメントを作成する
            await votingEventRepository.createVotingEvent({ roomId })
            functions.logger.info(`新しい votingEvent を作成しました。`)
        } catch (e) {
            functions.logger.error(`新規 VotingEvent ドキュメントの作成に失敗しました: ${e}`)
        }
    })

function calculateResult(votes: Vote[]): VoteEnum {
    // TODO: 'votes' is defined but never used. が出るので仮で設置した。後で消す。
    functions.logger.info(`${votes}`)
    return `hot`
}

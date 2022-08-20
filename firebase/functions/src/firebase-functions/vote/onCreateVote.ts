import * as functions from 'firebase-functions'
import { VotingEventRepository } from '~/src/repositories/voting_event'
import { VoteRepository } from '~/src/repositories/vote'
import { isNil } from 'lodash'
import { Vote } from '~/src/models/vote'
import { sendFCMByUserIds } from '~/src/utils/fcm/sendFCMNotification'

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
    // .runWith({failurePolicy:true})
    .firestore.document(`/rooms/{roomId}/votingEvents/{votingEventId}/votes/{voteId}`)
    .onCreate(async (snapshot,context) => {
        const {roomId, votingEventId} = context.params
        // votingEventのuserIdsを取得
        const votingEventRepository = new VotingEventRepository()
        const votingEvent = await votingEventRepository.fetchVotingEvent({ roomId,votingEventId })
        if(isNil(votingEvent)){
            functions.logger.error(`指定のVotingEventが存在しません: { roomId: ${roomId}, votingEventId: ${votingEventId} }`)
            return; 
        }
        const userIds = votingEvent.votingUserIds
        // votesのドキュメント数を取得
        const voteRepository = new VoteRepository()
        const votes = await voteRepository.fetchVotes({roomId,votingEventId})
        // 比較
        if(votes.length < userIds.length){
            return;
        }

        // 算出ロジックの実行
        const result = calculateResult(votes)

        //resultを更新
        try {
            await votingEventRepository.updateResult({roomId, votingEventId, result})
        } catch (e) {
            functions.logger.error(`resultの更新に失敗しました: { roomId: ${roomId}, votingEventId: ${votingEventId} }`)
            return; 
        }

        // votingEvent.votingUserIdsにプッシュ通知を送る
        await sendFCMByUserIds({userIds:userIds, title:`勝敗が決しました`, body:`結果画面で勝敗を確認してください`, location:`/` })

        try {
            // 新しいvotingEventドキュメントを作成する
            await votingEventRepository.createNewVotingEvent({roomId})
        } catch (e) {
            functions.logger.error(`新規VotingEventドキュメントの作成に失敗しました: ${e}`)
        }
    })

function calculateResult(votes: Vote[]) :VoteEnum {
    return `hot`
}    
import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'
import { VoteRepository } from '~/src/repositories/vote'
import { Vote } from '~/src/models/vote'
import { sendFCMByUserIds } from '~/src/utils/fcm/sendFCMNotification'
import { VotingEventRepository } from '~/src/repositories/votingEvent'
import { RoomRepository } from '~/src/repositories/room'
import { average } from '~/src/utils/calculation'

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

        const roomRepository = new RoomRepository()
        const room = await roomRepository.fetchRoom({ roomId })
        if (room === undefined) {
            functions.logger.error(`Room が見つかりませんでした。`)
            return
        }
        const { title, bodySuffix } = await fetchFCMTitleBodySuffix()
        await sendFCMByUserIds({
            userIds: userIds,
            title,
            body: `「${room.roomName}」${bodySuffix}`,
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

/** 結果を決定する。 */
function calculateResult(votes: Vote[]): VoteEnum {
    const averagePoint = average(votes.map((vote) => getPointByVoteEnum(vote.vote)))
    return getVoteEnumByPoint(averagePoint)
}

/** VoteEnum ごとの特典を取得する。 */
function getPointByVoteEnum(voteEnum: VoteEnum): number {
    switch (voteEnum) {
        case `extremelyCold`:
            return -2
        case `cold`:
            return -1
        case `comfortable`:
            return 0
        case `hot`:
            return 1
        case `extremelyHot`:
            return 2
    }
}

/** 特典から VoteEnum を決定する。 */
function getVoteEnumByPoint(point: number): VoteEnum {
    if (point > 1.5) {
        return `extremelyHot`
    } else if (point > 0.5) {
        return `hot`
    } else if (point > -0.5) {
        return `comfortable`
    } else if (point > -1.5) {
        return `cold`
    } else {
        return `extremelyCold`
    }
}

/** タイトルとボディ文字列の末尾を取得する */
const fetchFCMTitleBodySuffix = async (): Promise<{ title: string; bodySuffix: string }> => {
    const ds = await admin.firestore().collection(`fcms`).doc(`onCreateVote`).get()
    const data = ds.data()
    const title = data?.title ?? `エアコン戦争が勃発しました！`
    const bodySuffix = data?.bodySuffix ?? `エアコン戦争が勃発しました！！`
    return { title, bodySuffix }
}

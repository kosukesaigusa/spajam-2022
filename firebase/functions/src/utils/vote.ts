import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'
import { Vote } from '../models/vote'
import { RoomRepository } from '../repositories/room'
import { VotingEventRepository } from '../repositories/votingEvent'
import { average } from './calculation'
import { sendFCMByUserIds } from './fcm/sendFCMNotification'

/** votes に基づいて VotingEvent.result を更新し、完了する。  */
export const completeVotingEvent = async ({
    votes,
    roomId,
    votingEventId,
    userIds
}: {
    votes: Vote[]
    roomId: string
    votingEventId: string
    userIds: string[]
}): Promise<void> => {
    // 算出ロジックの実行
    const result = calculateResult(votes)
    functions.logger.info(`算出結果：${result}`)

    const votingEventRepository = new VotingEventRepository()

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
}

/** 結果を決定する。 */
export const calculateResult = (votes: Vote[]): VoteEnum => {
    const averagePoint = average(votes.map((vote) => getPointByVoteEnum(vote.vote)))
    return getVoteEnumByPoint(averagePoint)
}

/** VoteEnum ごとの特典を取得する。 */
export const getPointByVoteEnum = (voteEnum: VoteEnum): number => {
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
export const getVoteEnumByPoint = (point: number): VoteEnum => {
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
export const fetchFCMTitleBodySuffix = async (): Promise<{ title: string; bodySuffix: string }> => {
    const ds = await admin.firestore().collection(`fcms`).doc(`onCreateVote`).get()
    const data = ds.data()
    const title = data?.title ?? `エアコン戦争が勃発しました！`
    const bodySuffix = data?.bodySuffix ?? `エアコン戦争が勃発しました！！`
    return { title, bodySuffix }
}

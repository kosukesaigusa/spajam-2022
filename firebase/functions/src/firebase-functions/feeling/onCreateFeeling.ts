import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'
import { votingEventRef } from '~/src/firestore-refs/firestoreRefs'
import { FeelingRepository } from '~/src/repositories/feeling'
import { RoomRepository } from '~/src/repositories/room'
import { sendFCMByUserIds } from '~/src/utils/fcm/sendFCMNotification'

// room 内の user 数に対する相対値にできればなお良さそう
const unComfortableFeelingsCountThreshold = 1

export const onCreateFeeling = functions
    .region(`asia-northeast1`)
    .firestore.document(`/rooms/{roomId}/votingEvents/{votingEventId}/feelings/{feelingId}`)
    .onCreate(async (_, context) => {
        const roomId: string = context.params.roomId
        const votingEventId: string = context.params.votingEventId
        // feeling ドキュメントを全件取得する。
        const feelingRepository = new FeelingRepository()
        const feelings = await feelingRepository.fetchFeelings({
            roomId,
            votingEventId
        })
        // その votingEvent で初めて作成された feeling の場合
        if (feelings.length === 1) {
            functions.logger.info(`votingEvent を waiting に変更します。`)
            votingEventRef({ roomId, votingEventId }).update({ status: `waiting` })
        }
        // feelings の中の isComfortable: false な feeling ドキュメントの数
        const unComfortableFeelingsCount = feelings.filter((feeling) => feeling.isComfortable === false).length
        functions.logger.info(
            `現在の不快カウント：${unComfortableFeelingsCount} 件 / 閾値：${unComfortableFeelingsCountThreshold}`
        )
        // unComfortableFeelingsCount が badFeelingCountThreshold を超えていなければ return

        if (unComfortableFeelingsCount < unComfortableFeelingsCountThreshold) {
            functions.logger.info(`不快カウントが閾値に達していないのでまだステータスは waiting のままです。`)
            return
        }
        functions.logger.info(`戦争勃発！votingEvent を voting に変更します。`)
        votingEventRef({ roomId, votingEventId }).update({ status: `voting` })
        // roomId から room を取得する。
        const roomRepository = new RoomRepository()
        const room = await roomRepository.fetchRoom({ roomId })
        if (room === undefined) {
            functions.logger.error(`Room が見つかりませんでした。`)
            return
        }
        const userIds = room?.userIds ?? []
        // room.userIds を votingEvents の votingUserIds にコピーする。
        votingEventRef({ roomId, votingEventId }).update({ votingUserIds: userIds })
        const { title, bodySuffix } = await fetchFCMTitleBodySuffix()
        await sendFCMByUserIds({
            userIds,
            title,
            body: `「${room?.roomName}」の${bodySuffix}`,
            location: `/rooms/${roomId}/${votingEventId}`
        })
    })

/** タイトルとボディ文字列の末尾を取得する */
const fetchFCMTitleBodySuffix = async (): Promise<{ title: string; bodySuffix: string }> => {
    const ds = await admin.firestore().collection(`fcms`).doc(`onCreateFeeling`).get()
    const data = ds.data()
    const title = data?.title ?? `エアコン戦争が勃発しました！`
    const bodySuffix = data?.bodySuffix ?? `エアコン戦争が勃発しました！！`
    return { title, bodySuffix }
}

import * as functions from 'firebase-functions'
import { votingEventRef } from '~/src/firestore-refs/firestoreRefs'
import { FeelingRepository } from '~/src/repositories/feeling'
import { RoomRepository } from '~/src/repositories/room'
import { sendFCMByUserIds } from '~/src/utils/fcm/sendFCMNotification'

// room 内の user 数に対する相対値にできればなお良さそう
const unComfortableFeelingsCountThreshold = 3

export const onCreateFeeling = functions
    .region(`asia-northeast1`)
    .firestore.document(`/rooms/{roomId}/votingEvents/{votingEventId}/feelings/{feelingId}}`)
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
            // votingEvent の status を waiting に変更する
            votingEventRef({ roomId, votingEventId }).update({
                status: `waiting`
            })
        }
        // feelings の中の isComfortable: false な feeling ドキュメントの数
        const unComfortableFeelingsCount = feelings.filter((feeling) => feeling.isComfortable === false).length
        // unComfortableFeelingsCount が badFeelingCountThreshold を超えたら votingEvent の status を voting に変更する。
        if (unComfortableFeelingsCount >= unComfortableFeelingsCountThreshold) {
            votingEventRef({ roomId, votingEventId }).update({
                status: `voting`
            })
            // roomId から room を取得する。
            const roomRepository = new RoomRepository()
            const room = await roomRepository.fetchRoom({ roomId })
            const userIds = room?.userIds ?? []
            // room.userIds を votingEvents の votingUserIds にコピーする。
            votingEventRef({ roomId, votingEventId }).update({
                votingUserIds: userIds
            })
            await sendFCMByUserIds({
                userIds,
                title: `暑い寒い戦争が勃発しました！`,
                body: `暑い寒い戦争に参加してください！`,
                location: `/rooms/${roomId}/${votingEventId}`
            })
        }
    })

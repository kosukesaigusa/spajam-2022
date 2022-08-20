import { FieldValue } from '@google-cloud/firestore'
import * as admin from 'firebase-admin'
import * as functions from 'firebase-functions'
import { appUserConverter } from '~/src/converters/appUserConverter'
import { roomRef } from '~/src/firestore-refs/firestoreRefs'
import { RoomRepository } from '~/src/repositories/room'

/**
 * 新しい appUser ドキュメントが作成されたときに発火する。
 * トップレベルのすべての Room に該当ユーザーを所属させる。
 */
export const onCreateAppUser = functions
    .region(`asia-northeast1`)
    .firestore.document(`/appUsers/{appUserId}`)
    .onCreate(async (snapshot) => {
        const appUser = appUserConverter.fromFirestore(snapshot)
        const repository = new RoomRepository()
        const rooms = await repository.fetchRooms()
        const batch = admin.firestore().batch()
        for (const room of rooms) {
            batch.update(roomRef({ roomId: room.roomId }), {
                userIds: FieldValue.arrayUnion(appUser.userId)
            })
        }
        try {
            await batch.commit()
        } catch (e) {
            functions.logger.error(`appUser ドキュメントの作成に伴う各 Room への userIds の追加に失敗しました。`)
        }
    })

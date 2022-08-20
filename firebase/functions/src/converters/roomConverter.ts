import { FieldValue, FirestoreDataConverter } from '@google-cloud/firestore'
import { Room } from '../models/room'

export const roomConverter: FirestoreDataConverter<Room> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): Room {
        const data = qds.data()
        return {
            roomId: qds.id,
            roomName: data.roomName,
            userIds: data.userIds,
            votingEvents: data.votingEvents,
            createdAt: data.createdAt
        }
    },
    toFirestore(room: Room): FirebaseFirestore.DocumentData {
        return {
            roomId: room.roomId,
            roomName: room.roomName,
            userIds: room.userIds,
            votingEvents: room.votingEvents,
            createdAt: FieldValue.serverTimestamp()
        }
    }
}

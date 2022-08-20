import { roomRef, roomsRef } from '../firestore-refs/firestoreRefs'
import { Room } from '../models/room'

/** Room のリポジトリクラス */
export class RoomRepository {
    /** 指定した Room を取得する。 */
    async fetchRoom({ roomId }: { roomId: string }): Promise<Room | undefined> {
        const ds = await roomRef({ roomId: roomId }).get()
        return ds.data()
    }

    /** Room 一覧を取得する。 */
    async fetchRooms(): Promise<Room[]> {
        const qs = await roomsRef.get()
        return qs.docs.map((qds) => qds.data())
    }
}

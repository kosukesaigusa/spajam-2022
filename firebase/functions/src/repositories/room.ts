import { roomRef } from '../firestore-refs/firestoreRefs'
import { Room } from '../models/room'

/** Room のリポジトリクラス */
export class RoomRepository {
    /** 指定した Room を取得する。 */
    async fetchRoom({ roomId }: { roomId: string }): Promise<Room | undefined> {
        const ds = await roomRef({ roomId: roomId }).get()
        return ds.data()
    }
}

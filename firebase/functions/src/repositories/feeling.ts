import { feelingsRef } from '../firestore-refs/firestoreRefs'
import { Feeling } from '../models/feeling'

export class FeelingRepository {
    /** 指定した votingEvent の feeling を全件取得する */
    async fetchFeelings({ roomId, votingEventId }: { roomId: string; votingEventId: string }): Promise<Feeling[]> {
        const qs = await feelingsRef({ roomId, votingEventId }).get()
        return qs.docs.map((a) => a.data())
    }
}

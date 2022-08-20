import { votingEventsRef } from '../firestore-refs/firestoreRefs'
import { VotingEvent } from '../models/voting_event'

export class VotingEventRepository {
    /** 指定した room の votingEvent を全件取得する */
    async fetchVotingEvents({ roomId }: { roomId: string }): Promise<VotingEvent[]> {
        const qs = await votingEventsRef({ roomId }).get()
        return qs.docs.map((a) => a.data())
    }
}

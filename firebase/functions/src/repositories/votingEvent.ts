import { votingEventRef, votingEventsRef } from '../firestore-refs/firestoreRefs'
import { VotingEvent } from '../models/votingEvent'
import { v4 as uuidv4 } from 'uuid'

export class VotingEventRepository {
    /** 新しい VotingEvent を作成する。 */
    async createVotingEvent({ roomId }: { roomId: string }): Promise<void> {
        const votingEventId = uuidv4()
        const votingEvent: VotingEvent = {
            votingEventId,
            votingUserIds: [],
            status: `peace`,
            result: `comfortable`
        }
        await votingEventRef({ roomId, votingEventId }).set(votingEvent)
    }

    /** 指定したRoom の VotingEvent 一覧を取得する。 */
    async fetchVotingEvents({ roomId }: { roomId: string }): Promise<VotingEvent[]> {
        const qs = await votingEventsRef({ roomId: roomId }).get()
        return qs.docs.map((a) => a.data())
    }

    /** 指定したVotingEventを取得する。 */
    async fetchVotingEvent({
        roomId,
        votingEventId
    }: {
        roomId: string
        votingEventId: string
    }): Promise<VotingEvent | undefined> {
        const ds = await votingEventRef({ roomId, votingEventId }).get()
        return ds.data()
    }

    /**
     * VotingEvent.result を更新して、
     * VotingEvent.status を finished にする。 */
    async completeVotingEvent({
        roomId,
        votingEventId,
        result
    }: {
        roomId: string
        votingEventId: string
        result: VoteEnum
    }): Promise<void> {
        await votingEventRef({ roomId, votingEventId }).update({ result, status: `finished` })
    }
}

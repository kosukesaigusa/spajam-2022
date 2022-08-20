import * as admin from 'firebase-admin'
import { votingEventRef, votingEventsRef } from '../firestore-refs/firestoreRefs'
import { VotingEvent } from '../models/voting_event'

/** VotingEvent のリポジトリクラス */
export class VotingEventRepository {
    /** 指定したVotingEventを取得する。 */
    async createNewVotingEvent({ roomId }: { roomId: string }): Promise<string | undefined> {
        const doc = await votingEventsRef({ roomId: roomId }).doc()

        await doc.set({
            votingEventId: doc.id,
            votingUserIds: [],
            status: `peace`,
            feelings: [],
            votes: [],
            result: `comfortable`,
            createdAt: admin.firestore.FieldValue.serverTimestamp()
        })
        return doc.id
    }

    /** 指定したRoomの VotingEvent 一覧を取得する。 */
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
        const ds = await votingEventRef({ roomId: roomId, votingEventId: votingEventId }).get()
        return ds.data()
    }

    async updateResult({
        roomId,
        votingEventId,
        result
    }: {
        roomId: string
        votingEventId: string
        result: VoteEnum
    }): Promise<void> {
        await votingEventRef({ roomId: roomId, votingEventId: votingEventId }).update({ result: result })
    }
}

import { voteRef, votesRef } from '../firestore-refs/firestoreRefs'
import { Vote } from '../models/vote'

/** Vote のリポジトリクラス */
export class VoteRepository {
    /** 指定したRoomの Vote 一覧を取得する。 */
    async fetchVotes({ roomId, votingEventId }: { roomId: string; votingEventId: string }): Promise<Vote[]> {
        const qs = await votesRef({ roomId: roomId, votingEventId: votingEventId }).get()
        return qs.docs.map((a) => a.data())
    }

    async fetchVote({
        roomId,
        votingEventId,
        voteId
    }: {
        roomId: string
        votingEventId: string
        voteId: string
    }): Promise<Vote | undefined> {
        const ds = await voteRef({ roomId: roomId, votingEventId: votingEventId, voteId: voteId }).get()
        return ds.data()
    }
}

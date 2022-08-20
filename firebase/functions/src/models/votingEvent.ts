export class VotingEvent {
    votingEventId = ``
    votingUserIds: string[] = []
    status: VotingEventStatus = `peace`
    result: VoteEnum = `comfortable`
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<VotingEvent>) {
        Object.assign(this, partial)
    }
}

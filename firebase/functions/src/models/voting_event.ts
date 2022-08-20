export class VotingEvent {
    votingEventId = ``
    votingUserId = ``
    status = `peace`
    feelings = []
    votes = []
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<VotingEvent>) {
        Object.assign(this, partial)
    }
}

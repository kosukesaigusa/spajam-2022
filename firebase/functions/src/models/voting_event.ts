export class VotingEvent {
    votingEventId = ``
    votingUserId = ``
    status = `peace`
    feelings = []
    votes = []
    result = `comfortable`
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<VotingEvent>) {
        Object.assign(this, partial)
    }
}

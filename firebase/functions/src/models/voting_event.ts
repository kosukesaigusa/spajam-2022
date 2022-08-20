import { Feeling } from "./feeling"
import { Vote } from "./vote"

export class VotingEvent {
    votingEventId:string = ``
    votingUserIds:string[] = []
    status:VotingEventStatus = `peace`
    feelings: Feeling[] = []
    votes:Vote[] = []
    result:VoteEnum = `comfortable`
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<VotingEvent>) {
        Object.assign(this, partial)
    }
}

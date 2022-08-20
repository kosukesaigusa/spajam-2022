import { VotingEvent } from './voting_event'

export class Room {
    roomId = ``
    roomName = ``
    userIds: string[] = []
    votingEvents: VotingEvent[] = []
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<Room>) {
        Object.assign(this, partial)
    }
}

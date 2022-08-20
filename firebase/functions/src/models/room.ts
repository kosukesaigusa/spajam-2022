import { VotingEvent } from "./voting_event"

export class Room {
    roomId:string = ``
    roomName:string = ``
    userIds: string[] = []
    votingEvents: VotingEvent[] = []
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<Room>) {
        Object.assign(this, partial)
    }
}

export class Room {
    roomId = ``
    roomName = ``
    userIds = []
    votingEvents = []
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<Room>) {
        Object.assign(this, partial)
    }
}

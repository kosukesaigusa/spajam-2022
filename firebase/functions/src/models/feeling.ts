export class Feeling {
    feelingId = ``
    userId = ``
    isComfortable = false
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<Feeling>) {
        Object.assign(this, partial)
    }
}

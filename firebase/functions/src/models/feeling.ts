export class Feeling {
    feelingId:string = ``
    userId:string = ``
    isComfortable:boolean = false
    createdAt?: FirebaseFirestore.Timestamp

    constructor(partial?: Partial<Feeling>) {
        Object.assign(this, partial)
    }
}

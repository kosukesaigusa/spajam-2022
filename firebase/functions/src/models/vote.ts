export class Vote {
    voteId:string = ``
    userId:string = ``
    vote: VoteEnum = `comfortable`

    constructor(partial?: Partial<Vote>) {
        Object.assign(this, partial)
    }
}

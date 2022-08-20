export class Vote {
    voteId = ``
    userId = ``
    vote: VoteEnum = `comfortable`

    constructor(partial?: Partial<Vote>) {
        Object.assign(this, partial)
    }
}

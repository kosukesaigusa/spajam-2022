export class Vote {
    voteId = ``
    userId = ``
    vote = `comfortable`

    constructor(partial?: Partial<Vote>) {
        Object.assign(this, partial)
    }
}

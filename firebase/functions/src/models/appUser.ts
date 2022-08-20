export class AppUser {
    userId = ``
    fcmTokens: string[] = []

    constructor(partial?: Partial<AppUser>) {
        Object.assign(this, partial)
    }
}

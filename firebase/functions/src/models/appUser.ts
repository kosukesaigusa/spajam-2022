export class AppUser {
    userId:string = ``
    fcmToken: string = ``

    constructor(partial?: Partial<AppUser>) {
        Object.assign(this, partial)
    }
}

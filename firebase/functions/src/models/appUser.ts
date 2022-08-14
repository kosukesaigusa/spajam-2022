export class AppUser {
    userId = ``
    createdAt?: FirebaseFirestore.Timestamp
    updatedAt?: FirebaseFirestore.Timestamp
    name = ``
    fcmTokens: string[] = []

    constructor(partial?: Partial<AppUser>) {
        Object.assign(this, partial)
    }
}

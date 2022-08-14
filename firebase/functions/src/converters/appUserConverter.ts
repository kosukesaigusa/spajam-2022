import { FieldValue, FirestoreDataConverter } from '@google-cloud/firestore'
import { AppUser } from '../models/appUser'

export const appUserConverter: FirestoreDataConverter<AppUser> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): AppUser {
        const data = qds.data()
        return {
            userId: qds.id,
            createdAt: data.createdAt,
            updatedAt: data.updatedAt,
            name: data.name ?? ``,
            fcmTokens: data.fcmTokens ?? []
        }
    },
    toFirestore(appUser: AppUser): FirebaseFirestore.DocumentData {
        return {
            userId: appUser.userId,
            createdAt: FieldValue.serverTimestamp(),
            updatedAt: FieldValue.serverTimestamp(),
            name: appUser.name ?? ``,
            fcmTokens: appUser.fcmTokens ?? []
        }
    }
}

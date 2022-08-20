import { FirestoreDataConverter } from '@google-cloud/firestore'
import { AppUser } from '../models/appUser'

export const appUserConverter: FirestoreDataConverter<AppUser> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): AppUser {
        const data = qds.data()
        return {
            userId: qds.id,
            fcmTokens: data.fcmTokens ?? []
        }
    },
    toFirestore(appUser: AppUser): FirebaseFirestore.DocumentData {
        return {
            userId: appUser.userId,
            fcmToken: appUser.fcmTokens
        }
    }
}

import { FieldValue, FirestoreDataConverter } from '@google-cloud/firestore'
import { Feeling } from '../models/feeling'

export const feelingConverter: FirestoreDataConverter<Feeling> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): Feeling {
        const data = qds.data()
        return {
            feelingId: qds.id,
            userId: data.userId,
            isComfortable: data.isComfortable,
            createdAt: data.createdAt
        }
    },
    toFirestore(feeling: Feeling): FirebaseFirestore.DocumentData {
        return {
            feelingId: feeling.feelingId,
            userId: feeling.userId,
            isComfortable: feeling.isComfortable,
            createdAt: FieldValue.serverTimestamp()
        }
    }
}

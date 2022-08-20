import { FirestoreDataConverter } from '@google-cloud/firestore'
import { Vote } from '../models/vote'

export const voteConverter: FirestoreDataConverter<Vote> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): Vote {
        const data = qds.data()
        return {
            voteId: qds.id,
            userId: data.userId,
            vote: data.vote
        }
    },
    toFirestore(vote: Vote): FirebaseFirestore.DocumentData {
        return {
            voteId: vote.voteId,
            userId: vote.userId,
            vote: vote.vote
        }
    }
}

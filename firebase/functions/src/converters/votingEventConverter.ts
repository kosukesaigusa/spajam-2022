import { FieldValue, FirestoreDataConverter } from '@google-cloud/firestore'
import { VotingEvent } from '../models/votingEvent'

export const votingEventConverter: FirestoreDataConverter<VotingEvent> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): VotingEvent {
        const data = qds.data()
        return {
            votingEventId: qds.id,
            votingUserIds: data.votingUserIds,
            status: data.status,
            result: data.result,
            createdAt: data.createdAt
        }
    },
    toFirestore(votingEvent: VotingEvent): FirebaseFirestore.DocumentData {
        return {
            votingEventId: votingEvent.votingEventId,
            votingUserIds: votingEvent.votingUserIds,
            status: votingEvent.status,
            result: votingEvent.result,
            createdAt: FieldValue.serverTimestamp()
        }
    }
}

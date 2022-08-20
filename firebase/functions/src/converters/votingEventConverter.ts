import { FieldValue, FirestoreDataConverter } from '@google-cloud/firestore'
import { VotingEvent } from '../models/voting_event'

export const votingEventConverter: FirestoreDataConverter<VotingEvent> = {
    fromFirestore(qds: FirebaseFirestore.QueryDocumentSnapshot): VotingEvent {
        const data = qds.data()
        return {
            votingEventId: qds.id,
            votingUserIds: data.votingUserIds,
            status: data.status,
            feelings: data.feelings,
            votes: data.votes,
            result: data.result,
            createdAt: data.createdAt
        }
    },
    toFirestore(votingEvent: VotingEvent): FirebaseFirestore.DocumentData {
        return {
            votingEventId: votingEvent.votingEventId,
            votingUserIds: votingEvent.votingUserIds,
            status: votingEvent.status,
            feelings: votingEvent.feelings,
            votes: votingEvent.votes,
            result: votingEvent.result,
            createdAt: FieldValue.serverTimestamp()
        }
    }
}

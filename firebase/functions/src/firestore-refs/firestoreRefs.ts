import * as admin from 'firebase-admin'
import { CollectionReference, DocumentReference } from '@google-cloud/firestore'
import { AppUser } from '../models/appUser'
import { appUserConverter } from '../converters/appUserConverter'
import { Todo } from '../models/todo'
import { todoConverter } from '../converters/todoConverter'
import { Room } from '../models/room'
import { roomConverter } from '../converters/roomConverter'
import { VotingEvent } from '../models/votingEvent'
import { votingEventConverter } from '../converters/votingEventConverter'
import { Feeling } from '../models/feeling'
import { feelingConverter } from '../converters/feelingConverter'
import { Vote } from '../models/vote'
import { voteConverter } from '../converters/voteConverter'

/** undefined なプロパティを無視するよう設定した db オブジェクト。 */
const db = admin.firestore()
db.settings({ ignoreUndefinedProperties: true })

/** appUsers コレクションの参照 */
export const appUsersRef: CollectionReference<AppUser> = db
    .collection(`appUsers`)
    .withConverter<AppUser>(appUserConverter)

/** appUser ドキュメントの参照 */
export const appUserRef = ({ appUserId }: { appUserId: string }): DocumentReference<AppUser> =>
    appUsersRef.doc(appUserId)

/** todos コレクションの参照 */
export const todosRef = ({ appUserId }: { appUserId: string }): CollectionReference<Todo> =>
    appUserRef({ appUserId: appUserId }).collection(`todos`).withConverter<Todo>(todoConverter)

/** todo ドキュメントの参照 */
export const todoRef = ({ appUserId, todoId }: { appUserId: string; todoId: string }): DocumentReference<Todo> =>
    todosRef({ appUserId: appUserId }).doc(todoId)

/** rooms コレクションの参照 */
export const roomsRef = db.collection(`rooms`).withConverter<Room>(roomConverter)

/** room ドキュメントの参照 */
export const roomRef = ({ roomId }: { roomId: string }): DocumentReference<Room> => roomsRef.doc(roomId)

/** votingEvents コレクションの参照 */
export const votingEventsRef = ({ roomId }: { roomId: string }): CollectionReference<VotingEvent> =>
    roomRef({ roomId: roomId }).collection(`votingEvents`).withConverter<VotingEvent>(votingEventConverter)

/** votingEvent ドキュメントの参照 */
export const votingEventRef = ({
    roomId,
    votingEventId
}: {
    roomId: string
    votingEventId: string
}): DocumentReference<VotingEvent> => votingEventsRef({ roomId: roomId }).doc(votingEventId)

/** feelings コレクションの参照 */
export const feelingsRef = ({
    roomId,
    votingEventId
}: {
    roomId: string
    votingEventId: string
}): CollectionReference<Feeling> =>
    votingEventRef({ roomId: roomId, votingEventId: votingEventId })
        .collection(`feelings`)
        .withConverter<Feeling>(feelingConverter)

/** feeling ドキュメントの参照 */
export const feelingRef = ({
    roomId,
    votingEventId,
    feelingId
}: {
    roomId: string
    votingEventId: string
    feelingId: string
}): DocumentReference<Feeling> => feelingsRef({ roomId: roomId, votingEventId: votingEventId }).doc(feelingId)

/** votes コレクションの参照 */
export const votesRef = ({
    roomId,
    votingEventId
}: {
    roomId: string
    votingEventId: string
}): CollectionReference<Vote> =>
    votingEventRef({ roomId: roomId, votingEventId: votingEventId })
        .collection(`votes`)
        .withConverter<Vote>(voteConverter)

/** vote ドキュメントの参照 */
export const voteRef = ({
    roomId,
    votingEventId,
    voteId
}: {
    roomId: string
    votingEventId: string
    voteId: string
}): DocumentReference<Vote> => votesRef({ roomId: roomId, votingEventId: votingEventId }).doc(voteId)

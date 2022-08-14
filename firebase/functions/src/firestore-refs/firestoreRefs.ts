import * as admin from 'firebase-admin'
import { CollectionReference, DocumentReference } from '@google-cloud/firestore'
import { AppUser } from '../models/appUser'
import { appUserConverter } from '../converters/appUserConverter'
import { Todo } from '../models/todo'
import { todoConverter } from '../converters/todoConverter'

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

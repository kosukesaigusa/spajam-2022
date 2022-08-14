import * as functions from 'firebase-functions'
import { appUserConverter } from '~/src/converters/appUserConverter'
import { todoRef } from '~/src/firestore-refs/firestoreRefs'
import { Todo } from '~/src/models/todo'
import { v4 as uuidv4 } from 'uuid'

/**
 * 新しい appUser ドキュメントが作成されたときに発火する。
 * appUsers/{appUserId}/todos/{todoId} に最初の Todo をドキュメントを作成する。
 */
export const onCreateAppUser = functions
    .region(`asia-northeast1`)
    .firestore.document(`/appUsers/{appUserId}`)
    .onCreate(async (snapshot) => {
        const appUser = appUserConverter.fromFirestore(snapshot)
        const todo = new Todo({
            todoId: uuidv4(),
            userId: appUser.userId,
            title: `Todo のタイトル`,
            description: `Todo の説明`
        })
        try {
            await todoRef({ appUserId: appUser.userId, todoId: todo.todoId }).set(todo)
        } catch (e) {
            functions.logger.error(`appUser ドキュメントの作成に伴う todo の作成に失敗しました: ${e}`)
        }
    })

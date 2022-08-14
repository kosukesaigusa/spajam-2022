import { todosRef } from '../firestore-refs/firestoreRefs'
import { Todo } from '../models/todo'

/** Todo のリポジトリクラス */
export class TodoRepository {
    /** 指定したユーザーの Todo 一覧を取得する。 */
    async fetchTodos({ userId }: { userId: string }): Promise<Todo[]> {
        const qs = await todosRef({ appUserId: userId }).get()
        return qs.docs.map((a) => a.data())
    }
}

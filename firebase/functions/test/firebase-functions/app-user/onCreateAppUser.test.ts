import 'jest'
import { WrappedFunction, WrappedScheduledFunction } from 'firebase-functions-test/lib/main'
import { QueryDocumentSnapshot } from '@google-cloud/firestore'
import { AppUser } from '~/src/models/appUser'
import { testEnv } from '../../setUp'
import { onCreateAppUser } from '~/src/firebase-functions/app-user/onCreateAppUser'
import { TodoRepository } from '~/src/repositories/todo'

describe(`onCrateAppUser のテスト`, () => {
    let wrappedOnCreateAppUser: WrappedScheduledFunction | WrappedFunction<QueryDocumentSnapshot>
    beforeAll(() => {
        wrappedOnCreateAppUser = testEnv.wrap(onCreateAppUser)
    })

    test(`新しい appUser ドキュメントが作成されると、Todo ドキュメントが作成される。`, async () => {
        const userId = `test-user-id`
        const path = `appUsers/${userId}`
        const appUser = new AppUser({ userId })
        const snapshot = testEnv.firestore.makeDocumentSnapshot(appUser, path)

        // ラップした onCreateAppUser 関数を模擬的に実行する
        await wrappedOnCreateAppUser(snapshot)

        // 結果を検証する（publicUsers/:appUserId ドキュメントが作成されているはず）
        const repository = new TodoRepository()
        const todos = await repository.fetchTodos({ userId: userId })
        expect(todos.length).toBe(1)
        expect(todos[0]).toBeDefined()
        expect(todos[0].title).toBe(`Todo のタイトル`)
        expect(todos[0].description).toBe(`Todo の説明`)
    })
})

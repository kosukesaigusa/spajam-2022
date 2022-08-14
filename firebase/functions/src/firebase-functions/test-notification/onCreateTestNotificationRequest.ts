import * as functions from 'firebase-functions'
import { sendFCMByToken } from '~/src/utils/fcm/sendFCMNotification'

/**
 * テスト通知のリクエストドキュメントが作成されたときに発火して、
 * 該当 AppUser の FCM トークンにプッシュ通知を送信する。
 */
export const onCreateTestNotificationRequest = functions
    .region(`asia-northeast1`)
    .firestore.document(`testNotificationRequests/{requestId}`)
    .onCreate(async (snapshot) => {
        const data = snapshot.data()
        const token = data.token
        const title = `テスト通知`
        const body = `これはテスト通知です。タップすると現在のタブ上で通知の受けページに遷移します。`
        const path = `/test-notification`
        await sendFCMByToken({ token, title, body, path })
        functions.logger.log(`Test FCM notification succeeded.`)
    })

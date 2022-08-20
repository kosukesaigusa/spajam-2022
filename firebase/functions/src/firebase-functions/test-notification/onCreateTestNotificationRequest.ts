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
        const testNotificationRequestType: TestNotificationRequestType = data.testNotificationRequestType
        await sendFCMByToken({
            token,
            title: getTitle(testNotificationRequestType),
            body: getBody(testNotificationRequestType),
            location: getLocation(testNotificationRequestType)
        })
        functions.logger.log(`Test FCM notification succeeded.`)
    })

const getTitle = (testNotificationRequestType: TestNotificationRequestType): string => {
    if (testNotificationRequestType === `normal`) {
        return `テスト通知（通常）`
    } else if (testNotificationRequestType === `github`) {
        return `テスト通知（GitHub)`
    }
    return `テスト通知`
}

const getBody = (testNotificationRequestType: TestNotificationRequestType): string => {
    if (testNotificationRequestType === `normal`) {
        return `これはテスト通知です。タップすると現在のタブ上で通知の受けページに遷移します。`
    } else if (testNotificationRequestType === `github`) {
        return `これはテスト通知です。タップすると現在のタブ上で GitHub の spajam-2022 リポジトリの詳細ページに遷移します。`
    }
    return `これはテスト通知です。タップすると現在のタブ上で通知の受けページに遷移します。`
}

const getLocation = (testNotificationRequestType: TestNotificationRequestType): string => {
    if (testNotificationRequestType === `normal`) {
        return `/testNotification`
    } else if (testNotificationRequestType === `github`) {
        return `/repo/KosukeSaigusa/spajam-2022`
    }
    return `/testNotification`
}

import * as functions from 'firebase-functions'
import { messaging } from 'firebase-admin'
import { AppUserRepository } from '~/src/repositories/appUser'

/**
 * 1次元配列を 500 要素ずつの 2 次元配列に分割する
 */
const arrayChunk = ([...array], size = 500): string[][] => {
    return array.reduce((acc, _, index) => (index % size ? acc : [...acc, array.slice(index, index + size)]), [])
}

/**
 * FCMTarget（FCM トークンのリスト、現在のバッジカウントのリスト）、
 * 通知内容、通知をタップしたときに遷移するべきページの情報を受け取って、通知を送信する。
 * ひとりひとり現在のバッジカウントが異なっており、各ユーザーの複数の FCM トークンごとに
 * messaging.MulticastMessage を用いて送信する。
 * ひとりが 500 個以上の異なるトークンを保持することは本来想定していないが、500 個ごとに
 * チャンクして送信する。
 */
export const sendFCMByTargets = async ({
    fcmTargets,
    title,
    body,
    location
}: {
    fcmTargets: FCMTarget[]
    title: string
    body: string
    location: string
    documentId?: string
}): Promise<void> => {
    for (const fcmTarget of fcmTargets) {
        const twoDimensionTokens = arrayChunk(fcmTarget.fcmTokens)
        for (let i = 0; i < twoDimensionTokens.length; i++) {
            const message: messaging.MulticastMessage = {
                tokens: twoDimensionTokens[i],
                notification: { title, body },
                data: {
                    title,
                    body,
                    location,
                    click_action: `FLUTTER_NOTIFICATION_CLICK`,
                    id: `1`,
                    status: `done`
                },
                apns: {
                    headers: { 'apns-priority': `10` },
                    payload: {
                        aps: {
                            contentAvailable: true,
                            badge: fcmTarget.badgeNumber,
                            sound: `default`
                        }
                    }
                },
                android: {
                    priority: `high`,
                    notification: {
                        priority: `max`,
                        defaultSound: true,
                        notificationCount: 0 // 増加数
                    }
                }
            }
            const response = await messaging().sendMulticast(message)
            if (response.failureCount > 0) {
                const failedTokens: string[] = []
                response.responses.forEach((resp, j) => {
                    if (!resp.success) {
                        failedTokens.push(twoDimensionTokens[i][j])
                    }
                })
                functions.logger.warn(`送信に失敗した FCM Token（${response.failureCount}個）: ${failedTokens}`)
                return
            }
            functions.logger.log(`指定した全員に通知送信が成功しました`)
        }
    }
}

/**
 * 受け取った複数のユーザー ID から、Account ドキュメントを確認して、
 * その FCM Token と未読カウントから FCMTarget を作成し、
 * sendFCMByTargets に処理を渡す。
 */
export const sendFCMByUserIds = async ({
    userIds,
    title,
    body,
    location
}: {
    userIds: string[]
    title: string
    body: string
    location: string
}): Promise<void> => {
    const fcmTargets: FCMTarget[] = []
    for (const appUserId of userIds) {
        const appUserRepository = new AppUserRepository()
        const appUser = await appUserRepository.fetchAppUser({ appUserId })
        if (appUser === undefined) {
            continue
        }
        const fcmTokens = appUser.fcmTokens ?? []
        // TODO: 後で実装内容を考える
        const badgeNumber = 0
        fcmTargets.push({ fcmTokens, badgeNumber })
    }
    await sendFCMByTargets({ fcmTargets, title, body, location })
}

/**
 * 受け取った FCM トークンに対して通知を打つ。
 * テスト用。
 */
export const sendFCMByToken = async ({
    token,
    title,
    body,
    location
}: {
    token: string
    title: string
    body: string
    location: string
}): Promise<void> => {
    const fcmTargets: FCMTarget[] = [
        {
            fcmTokens: [token],
            badgeNumber: 1
        }
    ]
    await sendFCMByTargets({ fcmTargets, title, body, location })
}

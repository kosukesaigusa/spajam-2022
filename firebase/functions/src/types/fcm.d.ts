/**
 * あるユーザーの FCM トークンのリストと、現在のバッジカウントを
 * セット取り扱う型。
 */
interface FCMTarget {
    fcmTokens: string[]
    badgeNumber: number
}

type TestNotificationRequestType = `normal` | `github`

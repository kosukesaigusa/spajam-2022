import { appUserRef } from '../firestore-refs/firestoreRefs'
import { AppUser } from '../models/appUser'

/** AppUser のリポジトリクラス */
export class AppUserRepository {
    /** 指定した AppUser を取得する。 */
    async fetchAppUser({ appUserId }: { appUserId: string }): Promise<AppUser | undefined> {
        const ds = await appUserRef({ appUserId: appUserId }).get()
        return ds.data()
    }
}

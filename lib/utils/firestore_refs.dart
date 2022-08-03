import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';

final db = FirebaseFirestore.instance;

/// appUsers コレクションの参照。
final appUsersRef = db.collection('appUsers').withConverter(
      fromFirestore: (ds, _) => AppUser.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// appUser ドキュメントの参照
DocumentReference<AppUser> appUserRef({
  required String appUserId,
}) =>
    appUsersRef.doc(appUserId);

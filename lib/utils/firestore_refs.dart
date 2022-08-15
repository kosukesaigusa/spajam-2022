import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import '../models/test_notification_request.dart';
import '../models/todo.dart';

final db = FirebaseFirestore.instance;

/// appUsers コレクションの参照。
final appUsersRef = db.collection('appUsers').withConverter(
      fromFirestore: (ds, _) => AppUser.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// appUser ドキュメントの参照。
DocumentReference<AppUser> appUserRef({
  required String userId,
}) =>
    appUsersRef.doc(userId);

/// todo コレクションの参照。
CollectionReference<Todo> todosRef({
  required String userId,
}) =>
    appUserRef(userId: userId).collection('todos').withConverter(
          fromFirestore: (ds, _) => Todo.fromDocumentSnapshot(ds),
          toFirestore: (obj, _) => obj.toJson(),
        );

/// todo ドキュメントの参照。
DocumentReference<Todo> todoRef({
  required String userId,
  required String todoId,
}) =>
    todosRef(userId: userId).doc(todoId);

/// testNotificationRequest コレクションの参照。
final testNotificationRequestsRef = db.collection('testNotificationRequests').withConverter(
      fromFirestore: (ds, _) => TestNotificationRequest.fromDocumentSnapshot(ds),
      toFirestore: (obj, _) => obj.toJson(),
    );

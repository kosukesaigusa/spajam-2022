import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/test_notification_request.dart';
import '../../utils/firestore_refs.dart';

final testNotificationRequestRepositoryProvider =
    Provider.autoDispose((_) => TestNotificationRequestRepository());

class TestNotificationRequestRepository {
  /// TestNotificationRequest を作成する。
  Future<void> create(TestNotificationRequest testNotificationRequest) async {
    await testNotificationRequestsRef.add(testNotificationRequest);
  }
}

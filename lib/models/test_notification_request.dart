import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';

part 'test_notification_request.freezed.dart';
part 'test_notification_request.g.dart';

/// TestNotificationRequestの種別。
enum TestNotificationRequestType {
  normal('通常'),
  github('GitHub');

  const TestNotificationRequestType(this.label);

  final String label;
}

@freezed
class TestNotificationRequest with _$TestNotificationRequest {
  const factory TestNotificationRequest({
    @Default('') String token,
    @Default('') String testNotificationRequest,
    @Default(TestNotificationRequestType.normal)
        TestNotificationRequestType testNotificationRequestType,
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
  }) = _TestNotificationRequest;

  factory TestNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$TestNotificationRequestFromJson(json);

  factory TestNotificationRequest.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return TestNotificationRequest.fromJson(<String, dynamic>{
      ...data,
      'testNotificationRequest': ds.id,
    });
  }

  const TestNotificationRequest._();
}

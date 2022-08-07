import 'package:freezed_annotation/freezed_annotation.dart';

import 'owner.dart';

part 'github_repo.freezed.dart';
part 'github_repo.g.dart';

@freezed
class Repo with _$Repo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Repo({
    @Default(0) int id,
    @Default('') String name,
    @Default(Owner.defaultValue) Owner owner,
    @Default('') String htmlUrl,
    @Default('') String description,
    DateTime? updatedAt,
    @Default(0) int stargazersCount,
    @Default(0) int forksCount,
    @Default(0) int watchersCount,
  }) = _Repo;

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  static const defaultValue = Repo();
}

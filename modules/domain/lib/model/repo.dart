import 'package:domain/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repo.freezed.dart';
part 'repo.g.dart';

@freezed
class Repo with _$Repo {
  @JsonSerializable(explicitToJson: true)
  const factory Repo({
    required int id,
    required String name,
    required User owner,
    required List<String> topics,
    String? description,
  }) = _Repo;

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);
}

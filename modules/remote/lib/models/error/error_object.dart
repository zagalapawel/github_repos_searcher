import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_object.freezed.dart';
part 'error_object.g.dart';

@freezed
class ErrorObject with _$ErrorObject {
  const factory ErrorObject({
    String? status,
    String? message,
  }) = _ErrorObject;

  factory ErrorObject.fromJson(Map<String, dynamic> json) => _$ErrorObjectFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_detail.freezed.dart';

@freezed
class ErrorDetail with _$ErrorDetail {
  const factory ErrorDetail.backend({
    String? status,
    String? message,
    StackTrace? stackTrace,
  }) = ErrorDetailBackend;

  const factory ErrorDetail.fatal({
    Object? throwable,
    StackTrace? stackTrace,
  }) = ErrorDetailFatal;
}

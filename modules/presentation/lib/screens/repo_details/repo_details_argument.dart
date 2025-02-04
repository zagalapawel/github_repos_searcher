import 'package:domain/model/repo.dart';
import 'package:flutter/foundation.dart';

@immutable
class RepoDetailsArgument {
  const RepoDetailsArgument({
    required this.repo,
  });

  final Repo repo;

  Map<String, dynamic> toJson() => {
        'repo': repo.toJson(),
      };
}

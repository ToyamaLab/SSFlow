// Package imports:

// Package imports:
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:ssflow/models/_models.dart';

class SSElement with WithUuid {
  final String layoutType;

  /// textなら文字の中身など
  String? body;

  SSElement(
    this.layoutType, {
    this.body,
  }) {
    uuid = const Uuid().v4();
  }

  @override
  String toString() =>
      'SSElement uuid:[$uuid], type:[$layoutType], body:[$body]';
}

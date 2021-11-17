import 'package:ssflow/models/with_uuid.dart';
import 'package:uuid/uuid.dart';

class SSElement with WithUuid {
  final String layoutType;

  /// textなら文字の中身など
  String? body;

  SSElement(
    this.layoutType, {
    this.body,
  }) {
    this.uuid = Uuid().v4();
  }

  @override
  String toString() =>
      'SSElement uuid:[$uuid], type:[$layoutType], body:[$body]';
}

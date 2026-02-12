import 'package:prosnap/core/global/globals.dart';
import 'package:prosnap/core/services/local_db.dart';

class CurrentUser {
  static final CurrentUser _instance = CurrentUser._internal();
  CurrentUser._internal();
  factory CurrentUser() => _instance;

  Map _details = {};

  Future<void> save(Map data) async {
    _details = data;
    await LocalDb().userBox.put("details", data);
  }

  delete() async {
    _details.clear();
    await LocalDb().userBox.clear();
  }

  init() {
    _details = LocalDb().userBox.get("details") ?? {};
    logger.d(_details);
  }

  // GETTERS

  bool get registration => _details['registration'] ?? false;
  String get name => _details['name'] ?? "";
  String get bio => _details['bio'] ?? "";
}

import 'package:hive_flutter/hive_flutter.dart';

class LocalDb {
  static final LocalDb _instance = LocalDb._internal();
  LocalDb._internal();
  factory LocalDb() => _instance;

  Box? _userBox;
  Box? _appBox;

  Box get userBox => _userBox!;
  Box get appBox => _appBox!;

  init() async {
    await Hive.initFlutter();
    List<Box> boxes = await Future.wait([
      Hive.openBox("User"),
      Hive.openBox("App"),
    ]);

    _userBox = boxes[0];
    _appBox = boxes[1];
  }
}

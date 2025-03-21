import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_provides.g.dart';

@Riverpod(keepAlive: true)
class Counter extends _$Counter {
  @override
  int build() {
    return 5;
  }

  void increaseByOne() {
    state++;
  }
}

@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() {
    return false;
  }

  void toggleDarkMode() {
    state = !state;
  }
}


@Riverpod(keepAlive: true)
class Username extends _$Username {
  @override
  String build() {
    return 'Melissa Flores';
  }

  void changeUsername(String newUsername) {
    state = newUsername;
  }
}

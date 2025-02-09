//
// Generated file. Do not edit.
// This file is generated from template in file `flutter_tools/lib/src/flutter_plugins.dart`.
//

// @dart = 2.15

// When `package:socket_login_demo/main.dart` defines `main`, that definition is shadowed by the definition below.
export 'package:socket_login_demo/main.dart';

import 'package:socket_login_demo/main.dart' as entrypoint;
import 'dart:io'; // flutter_ignore: dart_io_import.
import 'package:google_sign_in_android/google_sign_in_android.dart';
import 'package:google_sign_in_ios/google_sign_in_ios.dart';

@pragma('vm:entry-point')
class _PluginRegistrant {

  @pragma('vm:entry-point')
  static void register() {
    if (Platform.isAndroid) {
      try {
        GoogleSignInAndroid.registerWith();
      } catch (err) {
        print(
          '`google_sign_in_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isIOS) {
      try {
        GoogleSignInIOS.registerWith();
      } catch (err) {
        print(
          '`google_sign_in_ios` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
        rethrow;
      }

    } else if (Platform.isLinux) {
    } else if (Platform.isMacOS) {
    } else if (Platform.isWindows) {
    }
  }

}

typedef _UnaryFunction = dynamic Function(List<String> args);
typedef _NullaryFunction = dynamic Function();

void main(List<String> args) {
  if (entrypoint.main is _UnaryFunction) {
    (entrypoint.main as _UnaryFunction)(args);
  } else {
    (entrypoint.main as _NullaryFunction)();
  }
}

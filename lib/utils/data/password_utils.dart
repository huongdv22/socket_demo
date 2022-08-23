import 'dart:math';

import 'package:socket_login_demo/core/app_constants.dart';
import 'package:string_unescape/string_unescape.dart';

final _random = Random();

class PasswordUtils {
  static int getRandomIntInclusive(var min, var max) {
    min = min.ceil();
    max = max.floor();
    return min + _random.nextInt(max - min + 1);
  }

  static int getKeySecret() {
    var randomRange = AppConst.maxSec - 1;
    var randomNumber = getRandomIntInclusive(0, randomRange);
    return randomNumber;
  }

  static String encryptString(String originalData) {
    String utf8 = unescape(Uri.encodeFull(originalData));
    List<int> textToEncrypt = [];
    for (int i = 0; i < utf8.length; i++) {
      textToEncrypt.add(utf8.codeUnitAt(i));
    }
    List mNumberArray = encrypt(textToEncrypt);

    String str = "";
    for (int j = 0; j < mNumberArray.length; j++) {
      str += String.fromCharCode(mNumberArray[j]);
    }

    return str;
  }

static  String decryptString(String originalData) {
    String utf8 = unescape(Uri.encodeFull(originalData));
    List<int> textToEncrypt = [];
    for (int i = 0; i < utf8.length; i++) {
      textToEncrypt.add(utf8.codeUnitAt(i));
    }
    List mNumberArray = decrypt(textToEncrypt);

    String str = "";
    for (int j = 0; j < mNumberArray.length; j++) {
      str += String.fromCharCode(mNumberArray[j]);
    }

    return str;
  }

   static List encrypt(List<int> inStr) {
    List outEncryptStr = [];
    int strLen = inStr.length;
    int j = 0, key = 0, x = 0, num = 0;

    key = getKeySecret();
    outEncryptStr.add(key + AppConst.basicNum);

    for (int i = 0; i < strLen; i++) {
      x = inStr[i] + AppConst.secret[key][j];

      j += 1;
      if (j == AppConst.maxItem) j = 0;

      num = 0;
      if (x > AppConst.basicNum) {
        num = (x / AppConst.basicNum).floor();
        x = x % AppConst.basicNum + AppConst.basicNum;
      }
      outEncryptStr.add(num + AppConst.basicNum);
      outEncryptStr.add(x);
    }

    return outEncryptStr;
  }

 static List decrypt(List<int> inStr) {
    List outDecryptStr = [];
    int strLen = inStr.length;
    int j = 0, key = 0, x = 0, num = 0;

    if (strLen % 2 == 0) return List.empty();

    key = inStr[0] - AppConst.basicNum;

    for (int i = 1; i < strLen; i++) {
      if (i % 2 != 0) {
        num = inStr[i] - AppConst.basicNum;
        continue;
      }

      if (num > 0) {
        x = (num * AppConst.basicNum) +
            inStr[i] -
            AppConst.basicNum -
            AppConst.secret[key][j];
      } else {
        x = inStr[i] - AppConst.secret[key][j];
      }

      j += 1;
      if (j == AppConst.maxItem) j = 0;

      if (x <= 0) return List.empty();

      outDecryptStr.add(x);
    }

    return outDecryptStr;
  }
}

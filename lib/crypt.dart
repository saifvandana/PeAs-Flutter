import 'dart:convert';
import 'package:encrypt/encrypt.dart';

class Crypt {
  static var encryption_iv = '7193201957163406';
  static var encryption_key = "EtliPilavErik\x00\x00\x00";

  static String encrypt(String input) {
    final encrypter = Encrypter(AES(Key(utf8.encode(encryption_key)),
        mode: AESMode.ctr, padding: null));

    final encrypted =
        encrypter.encrypt(input, iv: IV(utf8.encode(encryption_iv)));

    return base64
        .encode(utf8.encode(encrypted.base64))
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', ',');
  }

  static String decrypt(String input) {
    final decrypter = Encrypter(AES(Key(utf8.encode(encryption_key)),
        mode: AESMode.ctr, padding: null));

    var replace =
        input.replaceAll('-', '+').replaceAll('_', '/').replaceAll(',', '=');
    var decode =
        base64.decode(utf8.decode(base64.decode(base64.normalize(replace))));

    return decrypter.decrypt(Encrypted(decode),
        iv: IV(utf8.encode(encryption_iv)));
  }
}

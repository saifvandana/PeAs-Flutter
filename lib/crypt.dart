import 'dart:convert';
import 'package:encrypt/encrypt.dart';

/*
Provides methods to encrypt and decrypt data
*/

class Crypt {
  static var encryption_iv = '7193201957163406';
  //encryption key is padded with 3 null characters
  //since it is 3 characters behind the minimum of 16 bytes
  //required for AES encryption
  static var encryption_key = "EtliPilavErik\x00\x00\x00";

  //Takes a cleartext string as input
  //Returns encrypted string
  static String encrypt(String input) {
    final encrypter = Encrypter(AES(Key(utf8.encode(encryption_key)),
        mode: AESMode.ctr, padding: null));

    final encrypted =
        encrypter.encrypt(input, iv: IV(utf8.encode(encryption_iv)));

    //Twice base64 encode
    //Symbol replacements made as in server encryption algorithm
    return base64
        .encode(utf8.encode(encrypted.base64))
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', ',');
  }

  //Takes encrypted string as input
  //Returns cleartext string
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

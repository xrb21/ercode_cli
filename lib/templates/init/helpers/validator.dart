validator() {
  return """
import 'package:validators/validators.dart';

class Validator {
  static String? handphone(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (value.length < 9) return 'Nomor Handphone minimal 9 digit';
    return null;
  }

  static String? required(String? value) {
    if (value!.isEmpty) return 'Required';
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (value.length < 3) return 'Nama minimal 3 digit';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (value.length < 6) return 'Password minimal 6 digit';
    return null;
  }

  static String? retypePassword(String? value, String lastPassword) {
    if (value == null || value.isEmpty) return 'Required';
    if (value != lastPassword) return 'Ulangi Password Tidak Sama';
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (value.length < 3) return 'Kode OTP minimal 3 digit';
    return null;
  }

  static String? numberPositif(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!isNumeric(value)) {
      return 'Harus Berupa Angka';
    } else if (int.parse(value) <= 0) {
      return 'Harus lebih besar dari 0';
    } else {
      return null;
    }
  }

  static String? number(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!isNumeric(value)) {
      return 'Harus Berupa Angka';
    } else if (int.parse(value) < 0) {
      return 'Tidak boleh angka negatif';
    } else {
      return null;
    }
  }

  static String? kodePos(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!isNumeric(value)) {
      return 'Harus Berupa Angka';
    } else if (int.parse(value) < 0) {
      return 'Tidak boleh angka negatif';
    } else if (value.length != 5) {
      return 'Kodepos harus 5 digit';
    } else {
      return null;
    }
  }

  static String? numberPIN(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (!isNumeric(value)) {
      return 'Must Be a Number';
    } else if (int.parse(value) < 0) {
      return 'Must be greater than 0';
    } else if (value.length != 6) {
      return 'PIN must be 6 digit number';
    } else {
      return null;
    }
  }
}

""";
}

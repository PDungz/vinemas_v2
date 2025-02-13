import 'package:bcrypt/bcrypt.dart';

extension PasswordEncryption on String {
  /// Encrypts the current string as a password using bcrypt.
  String get encrypted => BCrypt.hashpw(this, BCrypt.gensalt());

  /// Verifies if the current string matches the given hashed password.
  bool verify(String hashedPassword) => BCrypt.checkpw(this, hashedPassword);
}
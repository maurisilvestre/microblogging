import 'package:dartz/dartz.dart';
import 'package:grupo_boticario/features/auth/domain/usecases/auth_email_password.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> authEmailPassword(
      String email, String password);
  Future<Either<Failure, User>> authGoogle();
}

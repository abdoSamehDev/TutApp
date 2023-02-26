import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/data/network/requests.dart';
import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/domain/repository/repository.dart';
import 'package:advanced_flutter_arabic/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.username,
        input.email,
        input.password,
        input.countryMobileCode,
        input.mobile,
        input.profilePic));
  }
}

class RegisterUseCaseInput {
  String username;
  String email;
  String password;
  String countryMobileCode;
  String mobile;
  String profilePic;

  RegisterUseCaseInput(
    this.username,
    this.email,
    this.password,
    this.countryMobileCode,
    this.mobile,
    this.profilePic,
  );
}

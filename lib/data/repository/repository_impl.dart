import 'package:advanced_flutter_arabic/data/data_source/remote_data_spurce.dart';
import 'package:advanced_flutter_arabic/data/mapper/mapper.dart';
import 'package:advanced_flutter_arabic/data/network/failure.dart';
import 'package:advanced_flutter_arabic/data/network/network_info.dart';
import 'package:advanced_flutter_arabic/data/network/requests.dart';
import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository{

  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {

    if(await _networkInfo.isConnected){
      final response = await _remoteDataSource.login(loginRequest);

      if(response.status == 0){
        //success
        return Right(response.toDomain());
      } else{
        //failure (business)
        return Left(Failure(409, response.message ?? "Business error message!"));
      }
    } else{
      //failure (connection)
      return Left(Failure(404, "Please check your internet connection!"));
    }

  }

}
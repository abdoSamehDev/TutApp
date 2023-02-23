import 'package:advanced_flutter_arabic/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter_arabic/data/mapper/mapper.dart';
import 'package:advanced_flutter_arabic/data/network/error_handler.dart';
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
      try{
        final response = await _remoteDataSource.login(loginRequest);

        if(response.status == ApiInternalStatus.success){
          //success
          return Right(response.toDomain());
        } else{
          //failure (business)
          return Left(Failure(ApiInternalStatus.failure, response.message ?? ResponseMessage.unknown));
        }
      }catch(error){
        return Left(ErrorHandler.handle(error).failure);
      }
    } else{
      //failure (connection)
      return Left(DataSource.noInternetConnection.getFailure());
    }

  }

}
import 'package:advanced_flutter_arabic/data/data_source/local_data_source.dart';
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
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo, this._localDataSource);
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

  @override
  Future<Either<Failure, ForgotPassword>> forgotPassword(String email) async {

    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.forgotPassword(email);

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

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {

    if(await _networkInfo.isConnected){
      try{
        final response = await _remoteDataSource.register(registerRequest);

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

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {

    try{
      //get response from cache
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch(cacheError){
      //cache is not existing or isn't valid so get from API side
      if(await _networkInfo.isConnected){
        try{
          final response = await _remoteDataSource.getHomeData();

          if(response.status == ApiInternalStatus.success){
            //success
            //save response to cache (local data source)
            _localDataSource.saveHomeToCache(response);
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

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {

    try{
      //get response from cache
      final response = await _localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch(cacheError){
      //cache is not existing or isn't valid so get from API side
      if(await _networkInfo.isConnected){
        try{
          final response = await _remoteDataSource.getStoreDetails();

          if(response.status == ApiInternalStatus.success){
            //success
            //save response to cache (local data source)
            _localDataSource.saveStoreDetailsToCache(response);
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

}
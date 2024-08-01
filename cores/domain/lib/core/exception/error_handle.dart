import 'package:domain/core/exception/app_error.dart';
import 'package:domain/core/exception/base_exception.dart';

abstract interface class ErrorHandler with BaseException{
  static late ErrorHandler _instance;

  static bool _isInitialized = false;

  static void setInstance(ErrorHandler errorHandle){
    _instance = errorHandle;

    _isInitialized = true;
  }

  static ErrorHandler getInstance(){
    if(_isInitialized){
      return _instance;
    }

    throw 'ErrorHandler have to set instance before to be used';
  }

  Future<T> call<T>({
    required Future<T> request,
  }) async {
    try {
      return await request;
    } catch (e) {
      observersError(e);

      if (e is AppError){
        if(errorMapperHandler(e) !=null){
          throw errorMapperHandler(e)!;
        }
        rethrow;
      }

      final appError = handleError(e);

      if(errorMapperHandler(appError) !=null){
        throw errorMapperHandler(appError)!;
      }

      throw appError;
    }
  }

  Future<T?> callNonObserver<T>({
    required Future<T> request,
  }) async {
    try {
      return await request;
    } catch (e) {
      if (e is AppError){
        if(errorMapperHandler(e) !=null){
          throw errorMapperHandler(e)!;
        }

        rethrow;
      }

      final appError = handleError(e);

      if(errorMapperHandler(appError) !=null){
        throw errorMapperHandler(appError)!;
      }

      throw appError;
    }
  }
}
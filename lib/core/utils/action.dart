import 'dart:io';

import 'package:dartz/dartz.dart';

import '../api/api_exceptions.dart';
import '../entities/app_error.dart';

Future<Either<AppError, T>> getAction<T>({
  required Future<dynamic> task,
  required T Function(dynamic) fromJson,
}) async {
  try {
    final response = await task;


    final result = fromJson(response);
    return Right(result);
  } on SocketException {
    return const Left(AppError(appErrorType: AppErrorType.network));
  } on UnauthorisedException {
    return const Left(AppError(appErrorType: AppErrorType.unauthorised));
  } on ExceptionWithMessage catch (e) {
    return Left(
        AppError(appErrorType: AppErrorType.msgError, errorMessage: e.message));
  } on Exception {
    return const Left(AppError(appErrorType: AppErrorType.api));
  }
}

Future<Either<AppError, T>> action<T>({
  required Future<dynamic> task,
}) async {
  try {
    final response = await task;

    return Right(response);
  } on SocketException {
    return const Left(AppError(appErrorType: AppErrorType.network));
  } on UnauthorisedException {
    return const Left(AppError(appErrorType: AppErrorType.unauthorised));
  } on ExceptionWithMessage catch (e) {
    return Left(
        AppError(appErrorType: AppErrorType.msgError, errorMessage: e.message));
  } on Exception {
    return const Left(AppError(appErrorType: AppErrorType.api));
  }
}
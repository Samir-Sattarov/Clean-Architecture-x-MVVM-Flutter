import 'dart:io';

import 'package:ca_mvvm/core/api/api_exceptions.dart';
import 'package:ca_mvvm/core/utils/action.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/api_constants.dart';
import '../../../../../core/entities/app_error.dart';
import '../../model/post_results_model.dart';

abstract class PostRepository {
  Future<Either<AppError, PostResultsModel>> getPostsResults();
}

class PostRepositoryImpl extends PostRepository {
  final ApiClient _client;

  PostRepositoryImpl(this._client);

  @override
  Future<Either<AppError, PostResultsModel>> getPostsResults() async {
    return await getAction<PostResultsModel>(
      task: _client.get(
        ApiConstants.posts,
        {},
      ),
      fromJson: (json) => PostResultsModel.fromJson(json),
    );
  }
}

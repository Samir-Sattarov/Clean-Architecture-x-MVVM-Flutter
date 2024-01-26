import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/post_results_model.dart';
import '../../../data/repositories/post/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _repository;
  PostCubit(this._repository) : super(PostInitial());

 Future load() async {

    emit(PostLoading());

    final response = await _repository.getPostsResults();

    response.fold(
      (l) => emit(PostError(message: l.errorMessage)),
      (r) => emit(PostLoaded(r)),
    );
  }
}

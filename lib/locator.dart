import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'core/api/api_client.dart';
import 'features/main/data/repositories/post/post_repository.dart';
import 'features/main/presentation/cubit/post_cubit/post_cubit.dart';
import 'features/main/presentation/views/post_view.dart';

final locator = GetIt.I;

void setup() {
  // ================ BLoC / Cubit / ViewModel ================ //


  locator.registerFactory(() => PostCubit(locator()));

  locator.registerLazySingleton(() => PostViewModel(locator()));

  // ================ Repository / Datasource ================ //

  locator.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(locator()));

  // ================ Core ================ //

  locator.registerLazySingleton<ApiClient>(() => ApiClientImpl(locator()));
  locator.registerLazySingleton<Client>(() => Client());

  // ================ External ================ //
}

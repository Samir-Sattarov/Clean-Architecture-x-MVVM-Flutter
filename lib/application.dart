import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'features/main/presentation/cubit/post_cubit/post_cubit.dart';
import 'features/main/presentation/views/post_view.dart';
import 'locator.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  late PostViewModel postViewModel;

  late PostCubit postCubit;
  @override
  void initState() {
    postViewModel = locator();
    postCubit = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: postViewModel),
        BlocProvider.value(value: postCubit),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          useMaterial3: false,
        ),
        home: const PostView(),
      ),
    );
  }
}

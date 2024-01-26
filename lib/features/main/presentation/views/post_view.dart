import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../data/model/post_results_model.dart';
import '../cubit/post_cubit/post_cubit.dart';
import '../widget/post_card_widget.dart';

class PostViewModel extends ChangeNotifier {
  final PostCubit postCubit;

  PostViewModel(this.postCubit);

  late PostResultsModel _results = PostResultsModel.empty();

  PostResultsModel get results => _results;

  load() async {
    postCubit.load();

    postCubit.stream.listen((state) {
      if (state is PostLoaded) {
        _results = state.results;
        notifyListeners();
      }
    });
  }
}

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    context.read<PostViewModel>().load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PostViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts View"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
          print('State is $state');
          if (state is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: context.watch<PostViewModel>().results.posts.length,
            itemBuilder: (context, index) {
              final item = viewModel.results.posts[index];
              return PostCardWidget(
                entity: item,
              );
            },
          );
        }),
      ),
    );
  }
}

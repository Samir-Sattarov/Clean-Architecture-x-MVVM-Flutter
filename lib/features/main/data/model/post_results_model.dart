import 'post_model.dart';

class PostResultsModel {
  final List<PostModel> posts;

  PostResultsModel({
    required this.posts,
  });

  factory PostResultsModel.empty() {
    return PostResultsModel(posts: []);
  }

  factory PostResultsModel.fromJson(List json) => PostResultsModel(
        posts: json.map((e) => PostModel.fromJson(e)).toList(),
      );
}

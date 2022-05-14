class Post
{
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "house": body,
    "userId": userId,
  };

  int? get getuserId => userId;
  int? get getid =>id;
  String? get gettitle => title;
  String? get getbody => body;
}

abstract class PostResult {}

// указывает на успешный запрос
class PostGetListResultSuccess extends PostResult
{
  List<Post> postList = [];
  PostGetListResultSuccess(this.postList);
}

class PostAddResultSuccess extends PostResult {}

// произошла ошибка
class PostResultFailure extends PostResult
{
  final String error;
  PostResultFailure(this.error);
}

// загрузка данных
class PostResultLoading extends PostResult { PostResultLoading(); }
class GetAllArticleModel {
  bool? success;
  String? message;
  int? statusCode;
  ArticlePayload? data;

  GetAllArticleModel({this.success, this.message, this.statusCode, this.data});

  GetAllArticleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? ArticlePayload.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    map['statusCode'] = statusCode;
    if (data != null) map['data'] = data!.toJson();
    return map;
  }
}

class ArticlePayload {
  Meta? meta;
  List<Article>? articles;

  ArticlePayload({this.meta, this.articles});

  ArticlePayload.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      articles = <Article>[];
      json['data'].forEach((v) {
        articles!.add(Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (meta != null) map['meta'] = meta!.toJson();
    if (articles != null) map['data'] = articles!.map((e) => e.toJson()).toList();
    return map;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPage': totalPage,
    };
  }
}

class Article {
  String? id;
  String? title;
  String? details;
  String? articleImage;
  String? createdAt;
  String? updatedAt;
  int? v;

  Article({
    this.id,
    this.title,
    this.details,
    this.articleImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    details = json['details'];
    articleImage = json['article_image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'details': details,
      'article_image': articleImage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

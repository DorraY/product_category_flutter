class Category {
  String id;
  String title;

  Category(this.id, this.title);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['_id'] as String,
      json['title'] as String,
    );
  }

}
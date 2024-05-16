class Category {
  Category({
    required this.id,
    required this.category,
    required this.imageCat,
  });

  final String? id;
  final String? category;
  final String? imageCat;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["_id"],
      category: json["category"],
      imageCat: json["imageCat"],
    );
  }

}

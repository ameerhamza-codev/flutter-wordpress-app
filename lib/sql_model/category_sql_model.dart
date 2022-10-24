class CategorySqlModel{
  int? categoryId;
  String? name,imageUrl;


  CategorySqlModel(this.categoryId, this.name, this.imageUrl);

  CategorySqlModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId']??0;
    name = json['name']??"";
    imageUrl = json['imageUrl']??"";

  }
}
class BusinessSqlModel{
  int? businessId,categoryId;
  String? name,imageUrl,address,contact,website;


  BusinessSqlModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId']??0;
    businessId = json['businessId']??0;
    address = json['address']??"";
    contact = json['contact']??"";
    website = json['website']??"";
    name = json['name']??"";
    imageUrl = json['imageUrl']??"";

  }
}
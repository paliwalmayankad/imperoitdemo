// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);





import 'package:flutter/cupertino.dart';

class SubCategoryModel {
  SubCategoryModel({
    this.status,
    this.message,
    this.result,
  });

  int status;
  String message;
  Result result;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    status: json["Status"],
    message: json["Message"],
    result: Result.fromJson(json["Result"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": result.toJson(),
  };
}

class Result {
  Result({
    this.category,
  });

  List<Category> category;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    category: List<Category>.from(json["Category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Category": List<dynamic>.from(category.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.isAuthorize,
    this.update080819,
    this.update130919,
    this.subCategories,
  });

  int id;
  String name;
  int isAuthorize;
  int update080819;
  int update130919;
  List<SubCategory> subCategories;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["Id"],
    name: json["Name"],
    isAuthorize: json["IsAuthorize"],
    update080819: json["Update080819"],
    update130919: json["Update130919"],
    subCategories: List<SubCategory>.from(json["SubCategories"].map((x) => SubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "IsAuthorize": isAuthorize,
    "Update080819": update080819,
    "Update130919": update130919,
    "SubCategories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
  };
}

class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.product,
    this.scrollController
  });

  int id;
  String name;
  List<Product> product;
  ScrollController scrollController=new ScrollController();

  bool isLoading=false;



  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["Id"],
    name: json["Name"],
    product: List<Product>.from(json["Product"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.name,
    this.priceCode,
    this.imageName,
    this.id,
  });

  String name;
  String priceCode;
  String imageName;
  int id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["Name"],
    priceCode: json["PriceCode"],
    imageName: json["ImageName"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "PriceCode": priceCode,
    "ImageName": imageName,
    "Id": id,
  };
}

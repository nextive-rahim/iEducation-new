// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  ProductDetailModel({
    this.data,
  });

  ProductDetailData? data;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        data: json["data"] == null
            ? null
            : ProductDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class ProductDetailData {
  ProductDetailData({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.photo,
    this.source,
    this.price,
    this.stock,
    this.active,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.otherDetails,
    this.metaData,
    this.specification,
    this.author,
    this.featured,
    this.isSubscribed,
    this.previews,
    this.authors,
    this.categories,
    this.reviews,
  });

  int? id;
  String? title;
  String? slug;
  String? description;
  String? photo;
  dynamic source;
  String? price;
  bool? stock;
  bool? active;
  dynamic discount;
  DateTime? discountTill;
  String? discountedPrice;
  dynamic otherDetails;
  dynamic metaData;
  dynamic specification;
  dynamic author;
  String? featured;
  bool? isSubscribed;
  List<dynamic>? previews;
  List<Author>? authors;
  List<Category>? categories;
  List<dynamic>? reviews;

  factory ProductDetailData.fromJson(Map<String, dynamic> json) =>
      ProductDetailData(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        photo: json["photo"],
        source: json["source"],
        price: json["price"],
        stock: json["stock"],
        active: json["active"],
        discount: json["discount"],
        discountTill: json["discount_till"] == null
            ? null
            : DateTime.parse(json["discount_till"]),
        discountedPrice:
            json["discounted_price"],
        otherDetails: json["other_details"],
        metaData: json["meta_data"],
        specification: json["specification"],
        author: json["author"],
        featured: json["featured"],
        isSubscribed:
            json["is_subscribed"],
        previews: json["previews"] == null
            ? null
            : List<dynamic>.from(json["previews"].map((x) => x)),
        authors: json["authors"] == null
            ? null
            : List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        reviews: json["reviews"] == null
            ? null
            : List<dynamic>.from(json["reviews"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "photo": photo,
        "source": source,
        "price": price,
        "stock": stock,
        "active": active,
        "discount": discount,
        "discount_till":
            discountTill == null ? null : discountTill!.toIso8601String(),
        "discounted_price": discountedPrice,
        "other_details": otherDetails,
        "meta_data": metaData,
        "specification": specification,
        "author": author,
        "featured": featured,
        "is_subscribed": isSubscribed,
        "previews": previews == null
            ? null
            : List<dynamic>.from(previews!.map((x) => x)),
        "authors": authors == null
            ? null
            : List<dynamic>.from(authors!.map((x) => x.toJson())),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "reviews":
            reviews == null ? null : List<dynamic>.from(reviews!.map((x) => x)),
      };
}

class Author {
  Author({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int? id;
  String? name;
  String? photo;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "description": description,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "pivot": pivot == null ? null : pivot!.toJson(),
      };
}

class Pivot {
  Pivot({
    this.authorableId,
    this.authorId,
    this.authorableType,
  });

  int? authorableId;
  int? authorId;
  String? authorableType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        authorableId:
            json["authorable_id"],
        authorId: json["author_id"],
        authorableType:
            json["authorable_type"],
      );

  Map<String, dynamic> toJson() => {
        "authorable_id": authorableId,
        "author_id": authorId,
        "authorable_type": authorableType,
      };
}

class Category {
  Category({
    this.id,
    this.parentId,
    this.name,
    this.slug,
    this.photo,
    this.order,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.active,
    this.featured,
    this.children,
    this.childrenCount,
  });

  int? id;
  dynamic parentId;
  String? name;
  dynamic slug;
  dynamic photo;
  int? order;
  dynamic price;
  dynamic discount;
  dynamic discountTill;
  dynamic discountedPrice;
  bool? active;
  bool? featured;
  List<dynamic>? children;
  int? childrenCount;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        slug: json["slug"],
        photo: json["photo"],
        order: json["order"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"],
        discountedPrice: json["discounted_price"],
        active: json["active"],
        featured: json["featured"],
        children: json["children"] == null
            ? null
            : List<dynamic>.from(json["children"].map((x) => x)),
        childrenCount:
            json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "slug": slug,
        "photo": photo,
        "order": order,
        "price": price,
        "discount": discount,
        "discount_till": discountTill,
        "discounted_price": discountedPrice,
        "active": active,
        "featured": featured,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x)),
        "children_count": childrenCount,
      };
}

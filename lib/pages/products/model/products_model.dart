// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.data,
    this.links,
    this.meta,
  });

  List<ProductModelData>? data;
  Links? links;
  Meta? meta;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: json["data"] == null
            ? null
            : List<ProductModelData>.from(
                json["data"].map((x) => ProductModelData.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links == null ? null : links!.toJson(),
        "meta": meta == null ? null : meta!.toJson(),
      };
}

class ProductModelData {
  ProductModelData({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.photo,
    this.source,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.otherDetails,
    this.metaData,
    this.specification,
    this.author,
    this.active,
    this.featured,
    this.isSubscribed,
    this.previews,
    this.categories,
  });

  int? id;
  String? title;
  String? slug;
  String? description;
  String? photo;
  dynamic source;
  String? price;
  String? discount;
  DateTime? discountTill;
  String? discountedPrice;
  String? otherDetails;
  String? metaData;
  String? specification;
  dynamic author;
  bool? active;
  String? featured;
  bool? isSubscribed;
  List<Preview>? previews;
  List<Category>? categories;

  factory ProductModelData.fromJson(Map<String, dynamic> json) =>
      ProductModelData(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        photo: json["photo"],
        source: json["source"],
        price: json["price"],
        discount: json["discount"],
        discountTill: json["discount_till"] == null
            ? null
            : DateTime.parse(json["discount_till"]),
        discountedPrice:
            json["discounted_price"],
        otherDetails:
            json["other_details"],
        metaData: json["meta_data"],
        specification:
            json["specification"],
        author: json["author"],
        active: json["active"],
        featured: json["featured"],
        isSubscribed:
            json["is_subscribed"],
        previews: json["previews"] == null
            ? null
            : List<Preview>.from(
                json["previews"].map((x) => Preview.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "photo": photo,
        "source": source,
        "price": price,
        "discount": discount,
        "discount_till":
            discountTill == null ? null : discountTill!.toIso8601String(),
        "discounted_price": discountedPrice,
        "other_details": otherDetails,
        "meta_data": metaData,
        "specification": specification,
        "author": author,
        "active": active,
        "featured": featured,
        "is_subscribed": isSubscribed,
        "previews": previews == null
            ? null
            : List<dynamic>.from(previews!.map((x) => x.toJson())),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
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
  dynamic name;
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

class Preview {
  Preview({
    this.id,
    this.createdBy,
    this.previewableType,
    this.previewableId,
    this.photo,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic createdBy;
  String? previewableType;
  int? previewableId;
  String? photo;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Preview.fromJson(Map<String, dynamic> json) => Preview(
        id: json["id"],
        createdBy: json["created_by"],
        previewableType:
            json["previewable_type"],
        previewableId:
            json["previewable_id"],
        photo: json["photo"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "previewable_type": previewableType,
        "previewable_id": previewableId,
        "photo": photo,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? null
            : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? null
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

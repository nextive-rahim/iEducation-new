// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    this.data,
  });

  PaymentModelData? data;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        data: json["data"] == null
            ? null
            : PaymentModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class PaymentModelData {
  PaymentModelData({
    this.id,
    this.userId,
    this.orderId,
    this.amount,
    this.transactionId,
    this.method,
    this.vendor,
    this.status,
    this.details,
    this.photo,
    this.paidAccount,
    this.paymentAccount,
    this.createdAt,
    this.order,
  });

  int? id;
  int? userId;
  int? orderId;
  String? amount;
  String? transactionId;
  String? method;
  String? vendor;
  String? status;
  dynamic details;
  dynamic photo;
  String? paidAccount;
  String? paymentAccount;
  DateTime? createdAt;
  Order? order;

  factory PaymentModelData.fromJson(Map<String, dynamic> json) =>
      PaymentModelData(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        amount: json["amount"],
        transactionId:
            json["transaction_id"],
        method: json["method"],
        vendor: json["vendor"],
        status: json["status"],
        details: json["details"],
        photo: json["photo"],
        paidAccount: json["paid_account"],
        paymentAccount:
            json["payment_account"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "amount": amount,
        "transaction_id": transactionId,
        "method": method,
        "vendor": vendor,
        "status": status,
        "details": details,
        "photo": photo,
        "paid_account": paidAccount,
        "payment_account": paymentAccount,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "order": order == null ? null : order!.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.address,
    this.total,
    this.discount,
    this.coupon,
    this.deliveryCharge,
    this.couponDiscount,
    this.grandTotal,
    this.paid,
    this.due,
    this.type,
    this.createdAt,
    this.status,
    this.sells,
  });

  int? id;
  int? userId;
  dynamic name;
  dynamic phone;
  Address? address;
  String? total;
  String? discount;
  dynamic coupon;
  dynamic deliveryCharge;
  dynamic couponDiscount;
  String? grandTotal;
  String? paid;
  String? due;
  dynamic type;
  DateTime? createdAt;
  String? status;
  List<Sell>? sells;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        total: json["total"],
        discount: json["discount"],
        coupon: json["coupon"],
        deliveryCharge: json["delivery_charge"],
        couponDiscount: json["coupon_discount"],
        grandTotal: json["grand_total"],
        paid: json["paid"],
        due: json["due"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        status: json["status"],
        sells: json["sells"] == null
            ? null
            : List<Sell>.from(json["sells"].map((x) => Sell.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "address": address == null ? null : address!.toJson(),
        "total": total,
        "discount": discount,
        "coupon": coupon,
        "delivery_charge": deliveryCharge,
        "coupon_discount": couponDiscount,
        "grand_total": grandTotal,
        "paid": paid,
        "due": due,
        "type": type,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "status": status,
        "sells": sells == null
            ? null
            : List<dynamic>.from(sells!.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.email,
    this.house,
    this.road,
    this.postOffice,
    this.postCode,
    this.village,
    this.city,
    this.country,
    this.subDistrict,
    this.district,
    this.division,
    this.state,
    this.floor,
    this.flat,
    this.body,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.address,
  });

  int? id;
  int? userId;
  String? name;
  String? phone;
  dynamic email;
  dynamic house;
  dynamic road;
  dynamic postOffice;
  dynamic postCode;
  dynamic village;
  dynamic city;
  dynamic country;
  dynamic subDistrict;
  dynamic district;
  dynamic division;
  dynamic state;
  dynamic floor;
  dynamic flat;
  dynamic body;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        house: json["house"],
        road: json["road"],
        postOffice: json["post_office"],
        postCode: json["post_code"],
        village: json["village"],
        city: json["city"],
        country: json["country"],
        subDistrict: json["sub_district"],
        district: json["district"],
        division: json["division"],
        state: json["state"],
        floor: json["floor"],
        flat: json["flat"],
        body: json["body"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "email": email,
        "house": house,
        "road": road,
        "post_office": postOffice,
        "post_code": postCode,
        "village": village,
        "city": city,
        "country": country,
        "sub_district": subDistrict,
        "district": district,
        "division": division,
        "state": state,
        "floor": floor,
        "flat": flat,
        "body": body,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "address": address,
      };
}

class Sell {
  Sell({
    this.id,
    this.userId,
    this.orderId,
    this.rate,
    this.quantity,
    this.total,
    this.itemName,
    this.sellable,
    this.photo,
    this.type,
  });

  int? id;
  int? userId;
  int? orderId;
  String? rate;
  String? quantity;
  String? total;
  String? itemName;
  Sellable? sellable;
  String? photo;
  String? type;

  factory Sell.fromJson(Map<String, dynamic> json) => Sell(
        id: json["id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        rate: json["rate"],
        quantity: json["quantity"],
        total: json["total"],
        itemName: json["item_name"],
        sellable: json["sellable"] == null
            ? null
            : Sellable.fromJson(json["sellable"]),
        photo: json["photo"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_id": orderId,
        "rate": rate,
        "quantity": quantity,
        "total": total,
        "item_name": itemName,
        "sellable": sellable == null ? null : sellable!.toJson(),
        "photo": photo,
        "type": type,
      };
}

class Sellable {
  Sellable({
    this.id,
    this.title,
    this.createdBy,
    this.slug,
    this.description,
    this.photo,
    this.source,
    this.price,
    this.discount,
    this.discountTill,
    this.discountedPrice,
    this.active,
    this.featured,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.specification,
    this.otherDetails,
    this.metaData,
    this.isSubscribed,
  });

  int? id;
  String? title;
  int? createdBy;
  String? slug;
  String? description;
  String? photo;
  dynamic source;
  String? price;
  String? discount;
  DateTime? discountTill;
  String? discountedPrice;
  bool? active;
  dynamic featured;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic specification;
  dynamic otherDetails;
  dynamic metaData;
  bool? isSubscribed;

  factory Sellable.fromJson(Map<String, dynamic> json) => Sellable(
        id: json["id"],
        title: json["title"],
        createdBy: json["created_by"],
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
        active: json["active"],
        featured: json["featured"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        specification: json["specification"],
        otherDetails: json["other_details"],
        metaData: json["meta_data"],
        isSubscribed:
            json["is_subscribed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_by": createdBy,
        "slug": slug,
        "description": description,
        "photo": photo,
        "source": source,
        "price": price,
        "discount": discount,
        "discount_till":
            discountTill == null ? null : discountTill!.toIso8601String(),
        "discounted_price": discountedPrice,
        "active": active,
        "featured": featured,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "specification": specification,
        "other_details": otherDetails,
        "meta_data": metaData,
        "is_subscribed": isSubscribed,
      };
}

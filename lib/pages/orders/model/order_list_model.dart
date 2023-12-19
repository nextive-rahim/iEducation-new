// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) =>
    OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  OrderListModel({
    this.data,
    this.links,
    this.meta,
  });

  List<OrderListData>? data;
  Links? links;
  Meta? meta;

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        data: json["data"] == null
            ? null
            : List<OrderListData>.from(
                json["data"].map((x) => OrderListData.fromJson(x))),
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

class OrderListData {
  OrderListData({
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
    this.payments,
    this.sells,
    this.user,
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
  dynamic status;
  List<Payment>? payments;
  List<Sell>? sells;
  User? user;

  factory OrderListData.fromJson(Map<String, dynamic> json) => OrderListData(
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
        payments: json["payments"] == null
            ? null
            : List<Payment>.from(
                json["payments"].map((x) => Payment.fromJson(x))),
        sells: json["sells"] == null
            ? null
            : List<Sell>.from(json["sells"].map((x) => Sell.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        "payments": payments == null
            ? null
            : List<dynamic>.from(payments!.map((x) => x.toJson())),
        "sells": sells == null
            ? null
            : List<dynamic>.from(sells!.map((x) => x.toJson())),
        "user": user == null ? null : user!.toJson(),
      };
}

class Address {
  Address({
    this.id,
    this.userId,
    this.address,
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
  });

  int? id;
  int? userId;
  String? address;
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

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        address: json["address"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address": address,
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
      };
}

class Payment {
  Payment({
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
  });

  int? id;
  int? userId;
  int? orderId;
  String? amount;
  String? transactionId;
  dynamic method;
  dynamic vendor;
  dynamic status;
  dynamic details;
  dynamic photo;
  String? paidAccount;
  String? paymentAccount;
  DateTime? createdAt;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
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
  dynamic type;

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
    this.author,
    this.isSubscribed,
    this.video,
    this.subtitle,
    this.difficulty,
    this.language,
    this.requirement,
    this.outcome,
    this.duration,
    this.approved,
    this.commission,
    this.canPreview,
    this.userCount,
    this.videoCount,
    this.audioCount,
    this.examCount,
    this.pdfCount,
    this.noteCount,
    this.linkCount,
    this.liveCount,
    this.zipCount,
    this.fileCount,
    this.writtenExamCount,
    this.rating,
    this.subscriptionStatus,
    this.fakeUserCount,
    this.requireGuardiansPhone,
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
  dynamic author;
  bool? isSubscribed;
  dynamic video;
  dynamic subtitle;
  dynamic difficulty;
  dynamic language;
  dynamic requirement;
  dynamic outcome;
  int? duration;
  bool? approved;
  dynamic commission;
  int? canPreview;
  dynamic userCount;
  int? videoCount;
  dynamic audioCount;
  dynamic examCount;
  dynamic pdfCount;
  dynamic noteCount;
  dynamic linkCount;
  dynamic liveCount;
  dynamic zipCount;
  dynamic fileCount;
  dynamic writtenExamCount;
  dynamic rating;
  dynamic subscriptionStatus;
  dynamic fakeUserCount;
  bool? requireGuardiansPhone;

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
        author: json["author"],
        isSubscribed:
            json["is_subscribed"],
        video: json["video"],
        subtitle: json["subtitle"],
        difficulty: json["difficulty"],
        language: json["language"],
        requirement: json["requirement"],
        outcome: json["outcome"],
        duration: json["duration"],
        approved: json["approved"],
        commission: json["commission"],
        canPreview: json["can_preview"],
        userCount: json["user_count"],
        videoCount: json["video_count"],
        audioCount: json["audio_count"],
        examCount: json["exam_count"],
        pdfCount: json["pdf_count"],
        noteCount: json["note_count"],
        linkCount: json["link_count"],
        liveCount: json["live_count"],
        zipCount: json["zip_count"],
        fileCount: json["file_count"],
        writtenExamCount: json["written_exam_count"],
        rating: json["rating"],
        subscriptionStatus: json["subscription_status"],
        fakeUserCount: json["fake_user_count"],
        requireGuardiansPhone: json["require_guardians_phone"],
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
        "author": author,
        "is_subscribed": isSubscribed,
        "video": video,
        "subtitle": subtitle,
        "difficulty": difficulty,
        "language": language,
        "requirement": requirement,
        "outcome": outcome,
        "duration": duration,
        "approved": approved,
        "commission": commission,
        "can_preview": canPreview,
        "user_count": userCount,
        "video_count": videoCount,
        "audio_count": audioCount,
        "exam_count": examCount,
        "pdf_count": pdfCount,
        "note_count": noteCount,
        "link_count": linkCount,
        "live_count": liveCount,
        "zip_count": zipCount,
        "file_count": fileCount,
        "written_exam_count": writtenExamCount,
        "rating": rating,
        "subscription_status": subscriptionStatus,
        "fake_user_count": fakeUserCount,
        "require_guardians_phone":
            requireGuardiansPhone,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.username,
    this.photo,
    this.phone,
    this.email,
    this.type,
    this.gender,
    this.dob,
    this.affiliation,
    this.subject,
    this.guardiansPhone,
    this.currentInstitution,
    this.varsity,
    this.college,
    this.school,
    this.lastLoginTime,
    this.approved,
    this.active,
    this.secondTimer,
    this.permissions,
    this.roles,
    this.district,
    this.ref,
    this.phoneVerifiedAt,
  });

  int? id;
  dynamic name;
  dynamic username;
  dynamic photo;
  String? phone;
  dynamic email;
  dynamic type;
  dynamic gender;
  String? dob;
  dynamic affiliation;
  dynamic subject;
  dynamic guardiansPhone;
  dynamic currentInstitution;
  dynamic varsity;
  dynamic college;
  dynamic school;
  dynamic lastLoginTime;
  bool? approved;
  bool? active;
  bool? secondTimer;
  List<String>? permissions;
  dynamic roles;
  dynamic district;
  dynamic ref;
  dynamic phoneVerifiedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        photo: json["photo"],
        phone: json["phone"],
        email: json["email"],
        type: json["type"],
        gender: json["gender"],
        dob: json["dob"],
        affiliation: json["affiliation"],
        subject: json["subject"],
        guardiansPhone: json["guardians_phone"],
        currentInstitution: json["current_institution"],
        varsity: json["varsity"],
        college: json["college"],
        school: json["school"],
        lastLoginTime: json["last_login_time"],
        approved: json["approved"],
        active: json["active"],
        secondTimer: json["second_timer"],
        permissions: json["permissions"] == null
            ? null
            : List<String>.from(json["permissions"].map((x) => x)),
        roles: json["roles"],
        district: json["district"],
        ref: json["ref"],
        phoneVerifiedAt: json["phone_verified_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "photo": photo,
        "phone": phone,
        "email": email,
        "type": type,
        "gender": gender,
        "dob": dob,
        "affiliation": affiliation,
        "subject": subject,
        "guardians_phone": guardiansPhone,
        "current_institution": currentInstitution,
        "varsity": varsity,
        "college": college,
        "school": school,
        "last_login_time": lastLoginTime,
        "approved": approved,
        "active": active,
        "second_timer": secondTimer,
        "permissions": permissions == null
            ? null
            : List<dynamic>.from(permissions!.map((x) => x)),
        "roles": roles,
        "district": district,
        "ref": ref,
        "phone_verified_at": phoneVerifiedAt,
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
  String? next;

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

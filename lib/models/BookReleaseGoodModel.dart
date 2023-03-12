import 'ReleaseGoodModel3.dart';

class BookReleaseGoodModel {
  BookReleaseGoodModel({
      required this.id,
      required this.confirmation,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.releasegoodId,
      required this.userId,
      required this.releasegood,
      required this.user,});

  BookReleaseGoodModel.fromJson(dynamic json) {
    id = json['id'];
    confirmation = json['confirmation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    releasegoodId = json['releasegood_id'];
    userId = json['user_id'];
    /*releasegood = (json['releasegood'] != null ? ReleaseGoodModel3.fromJson(json['releasegood']) : null)!;
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;*/

    releasegood = ( ReleaseGoodModel3.fromJson(json['releasegood']) );
    user = ( User.fromJson(json['user']) );
  }
  late dynamic id;
 late  dynamic confirmation;
  late String createdAt;
 late  String updatedAt;
 late  dynamic deletedAt;
 late  dynamic releasegoodId;
 late  dynamic userId;
 late  ReleaseGoodModel3 releasegood;
 late  User user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['confirmation'] = confirmation;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['releasegood_id'] = releasegoodId;
    map['user_id'] = userId;
    map['releasegood'] = releasegood.toJson();
    map['user'] = user.toJson();
    return map;
  }

}
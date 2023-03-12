class PropertyModel {
  PropertyModel({
      required this.id,
      required this.intitule,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,});

  PropertyModel.fromJson(dynamic json) {
    id = json['id'];
    intitule = json['intitule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
 late int id;
 late String intitule;
late  String createdAt;
 late String updatedAt;
 late dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['intitule'] = intitule;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}
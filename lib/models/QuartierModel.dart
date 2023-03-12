class QuartierModel {
  QuartierModel({
     required this.id,
     required this.intitule,
     required this.createdAt,
     required this.updatedAt,
     required this.deletedAt,
     required this.setCountriesId,
     required this.cityId,});

  QuartierModel.fromJson(dynamic json) {
    id = json['id'];
    intitule = json['intitule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    setCountriesId = json['set_countries_id'];
    cityId = json['city_id'];
  }
 late int id;
 late String intitule;
 late dynamic createdAt;
 late dynamic updatedAt;
 late dynamic deletedAt;
 late int setCountriesId;
 late int cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['intitule'] = intitule;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['set_countries_id'] = setCountriesId;
    map['city_id'] = cityId;
    return map;
  }

}


class CityModel {
  CityModel({
      required this.id,
      required this.intitule,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.setCountriesId,
      required this.setCountries,});

  CityModel.fromJson(dynamic json) {
    id = json['id'];
    intitule = json['intitule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    setCountriesId = json['set_countries_id'];
    setCountries = (json['set_countries'] != null ? SetCountries.fromJson(json['set_countries']) : null)!;
  }
  late int id;
  late String intitule;
  late String createdAt;
  late String updatedAt;
  late dynamic deletedAt;
  late int setCountriesId;
  late SetCountries setCountries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['intitule'] = intitule;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['set_countries_id'] = setCountriesId;
    if (setCountries != null) {
      map['set_countries'] = setCountries.toJson();
    }
    return map;
  }

}

class SetCountries {
  SetCountries({
    required this.id,
    required this.intitule,
    required this.code,
    required this.prefix,
    required this.flag,
    required this.statut,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,});

  SetCountries.fromJson(dynamic json) {
    id = json['id'];
    intitule = json['intitule'];
    code = json['code'];
    prefix = json['prefix'];
    flag = json['flag'];
    statut = json['statut'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
 late int id;
 late String intitule;
 late String code;
 late String prefix;
 late String flag;
 late String statut;
 late String createdAt;
 late String updatedAt;
 late dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['intitule'] = intitule;
    map['code'] = code;
    map['prefix'] = prefix;
    map['flag'] = flag;
    map['statut'] = statut;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}
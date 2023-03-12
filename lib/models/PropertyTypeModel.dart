/// data : [{"id":4,"intitule":"maison","created_at":"2022-09-30 04:23:21","updated_at":"2022-09-30 04:35:24","deleted_at":null},{"id":5,"intitule":"magasin","created_at":"2022-09-30 04:23:33","updated_at":"2022-10-08 05:52:07","deleted_at":null},{"id":7,"intitule":"parcelle","created_at":"2022-09-30 04:23:55","updated_at":"2022-09-30 04:24:53","deleted_at":null},{"id":8,"intitule":"terrain","created_at":"2022-09-30 04:26:21","updated_at":"2022-09-30 04:26:21","deleted_at":null},{"id":9,"intitule":"boutique","created_at":"2022-09-30 04:35:46","updated_at":"2022-09-30 04:35:46","deleted_at":null}]

class PropertyTypeModel {
  PropertyTypeModel({
      List<DataOfPropertyType>? data,}){
    _data = data;
}

  PropertyTypeModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DataOfPropertyType.fromJson(v));
      });
    }
  }
  List<DataOfPropertyType>? _data;
PropertyTypeModel copyWith({  List<DataOfPropertyType>? data,
}) => PropertyTypeModel(  data: data ?? _data,
);
  List<DataOfPropertyType>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4
/// intitule : "maison"
/// created_at : "2022-09-30 04:23:21"
/// updated_at : "2022-09-30 04:35:24"
/// deleted_at : null

class DataOfPropertyType {
  DataOfPropertyType({
      num? id, 
      String? intitule, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt,}){
    _id = id;
    _intitule = intitule;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  DataOfPropertyType.fromJson(dynamic json) {
    _id = json['id'];
    _intitule = json['intitule'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
  num? _id;
  String? _intitule;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
DataOfPropertyType copyWith({  num? id,
  String? intitule,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => DataOfPropertyType(  id: id ?? _id,
  intitule: intitule ?? _intitule,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
);
  num? get id => _id;
  String? get intitule => _intitule;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['intitule'] = _intitule;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }

}
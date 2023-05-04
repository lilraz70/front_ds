class Conveniences {
  Conveniences({
      required this.id,
      required this.intitule,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.morethanone,});

  Conveniences.fromJson(dynamic json) {
    id = json['id'];
    intitule = json['intitule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    morethanone = int.parse(json['morethanone']);
  //  morethanone = json['morethanone'];
  }
  late int id;
  late String intitule;
  late dynamic createdAt;
  late dynamic updatedAt;
  late dynamic deletedAt;
  late int morethanone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['intitule'] = intitule;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['morethanone'] = morethanone;
    return map;
  }

}
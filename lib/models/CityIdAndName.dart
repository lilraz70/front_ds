class CityIdAndName {
   var id;
   var intitule;

  CityIdAndName(this.id, this.intitule);

  CityIdAndName.fromJson(dynamic json)
      : id = json['id'],
        intitule = json['intitule'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'intitule': intitule,
  };
}
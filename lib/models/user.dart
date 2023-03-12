
List<User> addUserListFromJson(dynamic val)=> List<User>.from(
    val['data'].map((user) => User.userModelFromJson(user))
);


class User {
  final int? id;
  final String? name;
  final String? pseudo;
  final String? telephone;
  final String? photo_de_profil;
  final String? google_id;
  final String? facebook_id;
  User(
      {this.id,
      this.name,
     this.pseudo,
      this.telephone,
      this.photo_de_profil,
       this.google_id, this.facebook_id});

 // function to convert json data to user model
  factory User.fromJson(Map<String,dynamic> json) => User(
    id: json["user"]['id'],
    name: json["user"]['name'],
    pseudo: json["user"]['pseudo'],
    telephone: json["user"]['telephone'],
    photo_de_profil: json["user"]['photo_de_profil'],
    google_id: json["user"]['google_id'],
    facebook_id: json["user"]['facebook_id'],
  );
  factory User.userModelFromJson(Map<String,dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    pseudo: json['pseudo'],
    telephone: json['telephone'],
    photo_de_profil: json['photo_de_profil'],
    google_id: json['google_id'],
    facebook_id: json['facebook_id'],
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'pseudo':pseudo,
    'telephone':telephone,
    'photo_de_profil':photo_de_profil,
    'google_id':google_id,
    'facebook_id':facebook_id
  };
}

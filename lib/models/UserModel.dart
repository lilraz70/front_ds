/// id : 45
/// name : "Stephane"
/// email : "steph@user.com"
/// email_verified_at : null
/// verified : 0
/// verified_at : null
/// verification_token : "BLMZxg7NtY2sGmLCR2nmaSfB4kWtkAnNHeXVvGUKlnQns5LcEWntUu0mKUaPjqIR"
/// two_factor : 0
/// nom : null
/// prenoms : null
/// phone : "47522333255"
/// username : "steph"
/// set_countries_id : 1
/// two_factor_expires_at : null
/// created_at : "2023-01-07 20:55:59"
/// updated_at : "2023-01-07 20:55:59"
/// deleted_at : null
/// profil : null
/// roles : [{"id":2,"title":"User","created_at":null,"updated_at":null,"deleted_at":null,"pivot":{"user_id":45,"role_id":2}},{"id":2,"title":"User","created_at":null,"updated_at":null,"deleted_at":null,"pivot":{"user_id":45,"role_id":2}}]
/// media : []

class UserModel {
  UserModel({
      dynamic id, 
      String? name, 
      String? email, 
      dynamic emailVerifiedAt, 
      dynamic verified, 
      dynamic verifiedAt, 
      String? verificationToken, 
      dynamic twoFactor, 
      dynamic nom, 
      dynamic prenoms, 
      String? phone, 
      String? username, 
      dynamic setCountriesId, 
      dynamic twoFactorExpiresAt, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      dynamic profil, 
      List<Roles>? roles, 
      List<dynamic>? media,}){
    _id = id;
    _name = name;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _verified = verified;
    _verifiedAt = verifiedAt;
    _verificationToken = verificationToken;
    _twoFactor = twoFactor;
    _nom = nom;
    _prenoms = prenoms;
    _phone = phone;
    _username = username;
    _setCountriesId = setCountriesId;
    _twoFactorExpiresAt = twoFactorExpiresAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _profil = profil;
    _roles = roles;
    _media = media;
}

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _verified = json['verified'];
    _verifiedAt = json['verified_at'];
    _verificationToken = json['verification_token'];
    _twoFactor = json['two_factor'];
    _nom = json['nom'];
    _prenoms = json['prenoms'];
    _phone = json['phone'];
    _username = json['username'];
    _setCountriesId = json['set_countries_id'];
    _twoFactorExpiresAt = json['two_factor_expires_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _profil = json['profil'];
    if (json['roles'] != null) {
      _roles = [];
      json['roles'].forEach((v) {
        _roles?.add(Roles.fromJson(v));
      });
    }
   /* if (json['media'] != null) {
      _media = [];
      json['media'].forEach((v) {
        _media?.add(Dynamic.fromJson(v));
      });
    }*/
  }
  dynamic _id;
  String? _name;
  String? _email;
  dynamic _emailVerifiedAt;
  dynamic _verified;
  dynamic _verifiedAt;
  String? _verificationToken;
  dynamic _twoFactor;
  dynamic _nom;
  dynamic _prenoms;
  String? _phone;
  String? _username;
  dynamic _setCountriesId;
  dynamic _twoFactorExpiresAt;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  dynamic _profil;
  List<Roles>? _roles;
  List<dynamic>? _media;
UserModel copyWith({  dynamic id,
  String? name,
  String? email,
  dynamic emailVerifiedAt,
  dynamic verified,
  dynamic verifiedAt,
  String? verificationToken,
  dynamic twoFactor,
  dynamic nom,
  dynamic prenoms,
  String? phone,
  String? username,
  dynamic setCountriesId,
  dynamic twoFactorExpiresAt,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  dynamic profil,
  List<Roles>? roles,
  List<dynamic>? media,
}) => UserModel(  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
  verified: verified ?? _verified,
  verifiedAt: verifiedAt ?? _verifiedAt,
  verificationToken: verificationToken ?? _verificationToken,
  twoFactor: twoFactor ?? _twoFactor,
  nom: nom ?? _nom,
  prenoms: prenoms ?? _prenoms,
  phone: phone ?? _phone,
  username: username ?? _username,
  setCountriesId: setCountriesId ?? _setCountriesId,
  twoFactorExpiresAt: twoFactorExpiresAt ?? _twoFactorExpiresAt,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  profil: profil ?? _profil,
  roles: roles ?? _roles,
  media: media ?? _media,
);
  dynamic get id => _id;
  String? get name => _name;
  String? get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get verified => _verified;
  dynamic get verifiedAt => _verifiedAt;
  String? get verificationToken => _verificationToken;
  dynamic get twoFactor => _twoFactor;
  dynamic get nom => _nom;
  dynamic get prenoms => _prenoms;
  String? get phone => _phone;
  String? get username => _username;
  dynamic get setCountriesId => _setCountriesId;
  dynamic get twoFactorExpiresAt => _twoFactorExpiresAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  dynamic get profil => _profil;
  List<Roles>? get roles => _roles;
  List<dynamic>? get media => _media;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['verified'] = _verified;
    map['verified_at'] = _verifiedAt;
    map['verification_token'] = _verificationToken;
    map['two_factor'] = _twoFactor;
    map['nom'] = _nom;
    map['prenoms'] = _prenoms;
    map['phone'] = _phone;
    map['username'] = _username;
    map['set_countries_id'] = _setCountriesId;
    map['two_factor_expires_at'] = _twoFactorExpiresAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['profil'] = _profil;
    if (_roles != null) {
      map['roles'] = _roles?.map((v) => v.toJson()).toList();
    }
    if (_media != null) {
      map['media'] = _media?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// title : "User"
/// created_at : null
/// updated_at : null
/// deleted_at : null
/// pivot : {"user_id":45,"role_id":2}

class Roles {
  Roles({
      dynamic id, 
      String? title, 
      dynamic createdAt, 
      dynamic updatedAt, 
      dynamic deletedAt, 
      Pivot? pivot,}){
    _id = id;
    _title = title;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _pivot = pivot;
}

  Roles.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  dynamic _id;
  String? _title;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  Pivot? _pivot;
Roles copyWith({  dynamic id,
  String? title,
  dynamic createdAt,
  dynamic updatedAt,
  dynamic deletedAt,
  Pivot? pivot,
}) => Roles(  id: id ?? _id,
  title: title ?? _title,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  pivot: pivot ?? _pivot,
);
  dynamic get id => _id;
  String? get title => _title;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  Pivot? get pivot => _pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    if (_pivot != null) {
      map['pivot'] = _pivot?.toJson();
    }
    return map;
  }

}

/// user_id : 45
/// role_id : 2

class Pivot {
  Pivot({
      dynamic userId, 
      dynamic roleId,}){
    _userId = userId;
    _roleId = roleId;
}

  Pivot.fromJson(dynamic json) {
    _userId = json['user_id'];
    _roleId = json['role_id'];
  }
  dynamic _userId;
  dynamic _roleId;
Pivot copyWith({  dynamic userId,
  dynamic roleId,
}) => Pivot(  userId: userId ?? _userId,
  roleId: roleId ?? _roleId,
);
  dynamic get userId => _userId;
  dynamic get roleId => _roleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['role_id'] = _roleId;
    return map;
  }

}
/// id : 47
/// date_sorti_prevu : "2022-12-13 00:00:00"
/// conditions_bailleur : "coksks"
/// commentaires : null
/// nb_chambre : 2
/// localisation : "lo,ksdkqs"
/// geolocalisation : null
/// date_limite : "2022-12-13 00:00:00"
/// contact_bailleur : "75220022"
/// accord_bailleur : "1"
/// libelle : "MAISON410612226HN"
/// verif_accord_bailleur : null
/// cout : 75000
/// loyer_augmentera : "0"
/// created_at : "2022-12-06 14:22:47"
/// updated_at : "2022-12-06 14:22:47"
/// deleted_at : null
/// propertytype_id : 4
/// setcountry_id : 1
/// city_id : 1
/// quartier_id : 7
/// user_id : 33
/// liststatut_id : null
/// emergencylevel_id : 1
/// propertytype : {"id":4,"intitule":"maison","created_at":"2022-09-30 04:23:21","updated_at":"2022-09-30 04:35:24","deleted_at":null}
/// setcountry : {"id":1,"intitule":"Burkina Faso","code":"BF","prefix":"+226","flag":"bf.png","statut":"1","created_at":"2022-10-02 20:24:51","updated_at":"2022-10-02 20:25:23","deleted_at":null}
/// city : {"id":1,"intitule":"Ouagadougou","created_at":"2022-10-02 09:34:48","updated_at":"2022-10-02 09:34:48","deleted_at":null,"set_countries_id":1}
/// quartier : {"id":7,"intitule":"Samandin","created_at":null,"updated_at":null,"deleted_at":null,"set_countries_id":1,"city_id":1}
/// user : {"id":33,"name":"Kesseni","email":"kesseni1@yahoo.fr","email_verified_at":null,"verified":0,"verified_at":null,"verification_token":null,"two_factor":0,"nom":null,"prenoms":null,"phone":"66317070","username":"Kesseni","set_countries_id":1,"two_factor_expires_at":null,"created_at":"2022-11-17 13:26:48","updated_at":"2022-11-17 13:26:48","deleted_at":null,"profil":null,"media":[]}
/// liststatut : null
/// emergencylevel : {"id":1,"intitule":"Normal","created_at":"2022-10-05 05:14:46","updated_at":"2022-10-05 05:14:46","deleted_at":null}
/// releasegoodconvenience : [{"id":169,"created_at":"2022-12-06 14:22:47","updated_at":"2022-12-06 14:22:47","deleted_at":null,"releasegood_id":47,"conveniencetype_id":6,"number":2,"conveniencetype":{"id":6,"intitule":"Garage","created_at":"2022-09-30 07:05:33","updated_at":"2022-09-30 07:05:33","deleted_at":null,"morethanone":1}},{"id":170,"created_at":"2022-12-06 14:22:47","updated_at":"2022-12-06 14:22:47","deleted_at":null,"releasegood_id":47,"conveniencetype_id":5,"number":2,"conveniencetype":{"id":5,"intitule":"Douche Interne","created_at":"2022-09-30 07:05:21","updated_at":"2022-09-30 07:05:21","deleted_at":null,"morethanone":1}},{"id":171,"created_at":"2022-12-06 14:22:47","updated_at":"2022-12-06 14:22:47","deleted_at":null,"releasegood_id":47,"conveniencetype_id":4,"number":1,"conveniencetype":{"id":4,"intitule":"Cuisine Interne","created_at":"2022-09-30 07:05:07","updated_at":"2022-09-30 07:05:07","deleted_at":null,"morethanone":0}},{"id":172,"created_at":"2022-12-06 14:22:47","updated_at":"2022-12-06 14:22:47","deleted_at":null,"releasegood_id":47,"conveniencetype_id":2,"number":1,"conveniencetype":{"id":2,"intitule":"Climatisation","created_at":"2022-09-30 07:04:41","updated_at":"2022-09-30 07:04:41","deleted_at":null,"morethanone":0}},{"id":173,"created_at":"2022-12-06 14:22:47","updated_at":"2022-12-06 14:22:47","deleted_at":null,"releasegood_id":47,"conveniencetype_id":1,"number":1,"conveniencetype":{"id":1,"intitule":"Ventilation","created_at":"2022-09-30 07:04:21","updated_at":"2022-09-30 07:04:21","deleted_at":null,"morethanone":0}}]

class ReleaseGoodModel3 {
  ReleaseGoodModel3({
    dynamic id,
    dynamic dateSortiPrevu,
    dynamic conditionsBailleur,
    dynamic commentaires,
    dynamic nbChambre,
    dynamic localisation,
    dynamic geolocalisation,
    dynamic dateLimite,
    dynamic contactBailleur,
    dynamic accordBailleur,
    dynamic libelle,
    dynamic verifAccordBailleur,
    dynamic cout,
    dynamic loyerAugmentera,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic propertytypeId,
    dynamic setcountryId,
    dynamic cityId,
    dynamic quartierId,
    dynamic userId,
    dynamic liststatutId,
    dynamic emergencylevelId,
    Propertytype? propertytype,
    Setcountry? setcountry,
    City? city,
    Quartier? quartier,
    User? user,
    dynamic liststatut,
    Emergencylevel? emergencylevel,
    String? image_url,
    List? images,
    List<Releasegoodconvenience>? releasegoodconvenience,
  }) {
    _image_url = image_url;
    _images = images ?? [];
    _id = id;
    _dateSortiPrevu = dateSortiPrevu;
    _conditionsBailleur = conditionsBailleur;
    _commentaires = commentaires;
    _nbChambre = nbChambre;
    _localisation = localisation;
    _geolocalisation = geolocalisation;
    _dateLimite = dateLimite;
    _contactBailleur = contactBailleur;
    _accordBailleur = accordBailleur;
    _libelle = libelle;
    _verifAccordBailleur = verifAccordBailleur;
    _cout = cout;
    _loyerAugmentera = loyerAugmentera;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _propertytypeId = propertytypeId;
    _setcountryId = setcountryId;
    _cityId = cityId;
    _quartierId = quartierId;
    _userId = userId;
    _liststatutId = liststatutId;
    _emergencylevelId = emergencylevelId;
    _propertytype = propertytype;
    _setcountry = setcountry;
    _city = city;
    _quartier = quartier;
    _user = user;
    _liststatut = liststatut;
    _emergencylevel = emergencylevel;
    _releasegoodconvenience = releasegoodconvenience ?? [];
  }

  ReleaseGoodModel3.fromJson(dynamic json) {
    _image_url = json['image_url'];
    _images = json['images'] ?? [];
    _id = json['id'];
    _dateSortiPrevu = json['date_sorti_prevu'];
    _conditionsBailleur = json['conditions_bailleur'];
    _commentaires = json['commentaires'];
    _nbChambre = json['nb_chambre'];
    _localisation = json['localisation'];
    _geolocalisation = json['geolocalisation'];
    _dateLimite = json['date_limite'];
    _contactBailleur = json['contact_bailleur'];
    _accordBailleur = json['accord_bailleur'];
    _libelle = json['libelle'];
    _verifAccordBailleur = json['verif_accord_bailleur'];
    _cout = json['cout'];
    _loyerAugmentera = json['loyer_augmentera'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _propertytypeId = json['propertytype_id'];
    _setcountryId = json['setcountry_id'];
    _cityId = json['city_id'];
    _quartierId = json['quartier_id'];
    _userId = json['user_id'];
    _liststatutId = json['liststatut_id'];
    _emergencylevelId = json['emergencylevel_id'];
    _propertytype = json['propertytype'] != null
        ? Propertytype.fromJson(json['propertytype'])
        : null;
    _setcountry = json['setcountry'] != null
        ? Setcountry.fromJson(json['setcountry'])
        : null;
    _city = json['city'] != null ? City.fromJson(json['city']) : null;
    _quartier =
        json['quartier'] != null ? Quartier.fromJson(json['quartier']) : null;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _liststatut = json['liststatut'];
    _emergencylevel = json['emergencylevel'] != null
        ? Emergencylevel.fromJson(json['emergencylevel'])
        : null;
    if (json['releasegoodconvenience'] != null) {
      _releasegoodconvenience = [];
      json['releasegoodconvenience'].forEach((v) {
        _releasegoodconvenience?.add(Releasegoodconvenience.fromJson(v));
      });
    } else {
      _releasegoodconvenience = [];
    }
  }

  String? _image_url;
  List? _images;
  dynamic _id;
  dynamic _dateSortiPrevu;
  dynamic _conditionsBailleur;
  dynamic _commentaires;
  dynamic _nbChambre;
  dynamic _localisation;
  dynamic _geolocalisation;
  dynamic _dateLimite;
  dynamic _contactBailleur;
  dynamic _accordBailleur;
  dynamic _libelle;
  dynamic _verifAccordBailleur;
  dynamic _cout;
  dynamic _loyerAugmentera;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  dynamic _propertytypeId;
  dynamic _setcountryId;
  dynamic _cityId;
  dynamic _quartierId;
  dynamic _userId;
  dynamic _liststatutId;
  dynamic _emergencylevelId;
  Propertytype? _propertytype;
  Setcountry? _setcountry;
  City? _city;
  Quartier? _quartier;
  User? _user;
  dynamic _liststatut;
  Emergencylevel? _emergencylevel;
  List<Releasegoodconvenience>? _releasegoodconvenience;

  ReleaseGoodModel3 copyWith({
    String? image_url,
    List? images,
    dynamic id,
    dynamic dateSortiPrevu,
    dynamic conditionsBailleur,
    dynamic commentaires,
    dynamic nbChambre,
    dynamic localisation,
    dynamic geolocalisation,
    dynamic dateLimite,
    dynamic contactBailleur,
    dynamic accordBailleur,
    dynamic libelle,
    dynamic verifAccordBailleur,
    dynamic cout,
    dynamic loyerAugmentera,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic propertytypeId,
    dynamic setcountryId,
    dynamic cityId,
    dynamic quartierId,
    dynamic userId,
    dynamic liststatutId,
    dynamic emergencylevelId,
    Propertytype? propertytype,
    Setcountry? setcountry,
    City? city,
    Quartier? quartier,
    User? user,
    dynamic liststatut,
    Emergencylevel? emergencylevel,
    List<Releasegoodconvenience>? releasegoodconvenience,
  }) =>
      ReleaseGoodModel3(
        image_url: image_url ?? _image_url,
        images: images ?? _images,
        id: id ?? _id,
        dateSortiPrevu: dateSortiPrevu ?? _dateSortiPrevu,
        conditionsBailleur: conditionsBailleur ?? _conditionsBailleur,
        commentaires: commentaires ?? _commentaires,
        nbChambre: nbChambre ?? _nbChambre,
        localisation: localisation ?? _localisation,
        geolocalisation: geolocalisation ?? _geolocalisation,
        dateLimite: dateLimite ?? _dateLimite,
        contactBailleur: contactBailleur ?? _contactBailleur,
        accordBailleur: accordBailleur ?? _accordBailleur,
        libelle: libelle ?? _libelle,
        verifAccordBailleur: verifAccordBailleur ?? _verifAccordBailleur,
        cout: cout ?? _cout,
        loyerAugmentera: loyerAugmentera ?? _loyerAugmentera,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        propertytypeId: propertytypeId ?? _propertytypeId,
        setcountryId: setcountryId ?? _setcountryId,
        cityId: cityId ?? _cityId,
        quartierId: quartierId ?? _quartierId,
        userId: userId ?? _userId,
        liststatutId: liststatutId ?? _liststatutId,
        emergencylevelId: emergencylevelId ?? _emergencylevelId,
        propertytype: propertytype ?? _propertytype,
        setcountry: setcountry ?? _setcountry,
        city: city ?? _city,
        quartier: quartier ?? _quartier,
        user: user ?? _user,
        liststatut: liststatut ?? _liststatut,
        emergencylevel: emergencylevel ?? _emergencylevel,
        releasegoodconvenience:
            releasegoodconvenience ?? _releasegoodconvenience,
      );

  String? get image_url => _image_url;

  List? get images => _images ?? [];

  dynamic get id => _id;

  dynamic get dateSortiPrevu => _dateSortiPrevu;

  dynamic get conditionsBailleur => _conditionsBailleur;

  dynamic get commentaires => _commentaires;

  dynamic get nbChambre => _nbChambre;

  dynamic get localisation => _localisation;

  dynamic get geolocalisation => _geolocalisation;

  dynamic get dateLimite => _dateLimite;

  dynamic get contactBailleur => _contactBailleur;

  dynamic get accordBailleur => _accordBailleur;

  dynamic get libelle => _libelle;

  dynamic get verifAccordBailleur => _verifAccordBailleur;

  dynamic get cout => _cout;

  dynamic get loyerAugmentera => _loyerAugmentera;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  dynamic get propertytypeId => _propertytypeId;

  dynamic get setcountryId => _setcountryId;

  dynamic get cityId => _cityId;

  dynamic get quartierId => _quartierId;

  dynamic get userId => _userId;

  dynamic get liststatutId => _liststatutId;

  dynamic get emergencylevelId => _emergencylevelId;

  Propertytype? get propertytype => _propertytype;

  Setcountry? get setcountry => _setcountry;

  City? get city => _city;

  Quartier? get quartier => _quartier;

  User? get user => _user;

  dynamic get liststatut => _liststatut;

  Emergencylevel? get emergencylevel => _emergencylevel;

  List<Releasegoodconvenience>? get releasegoodconvenience =>
      _releasegoodconvenience ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image_url'] = _image_url;
    map['images'] = _images ?? [];
    map['id'] = _id;
    map['date_sorti_prevu'] = _dateSortiPrevu;
    map['conditions_bailleur'] = _conditionsBailleur;
    map['commentaires'] = _commentaires;
    map['nb_chambre'] = _nbChambre;
    map['localisation'] = _localisation;
    map['geolocalisation'] = _geolocalisation;
    map['date_limite'] = _dateLimite;
    map['contact_bailleur'] = _contactBailleur;
    map['accord_bailleur'] = _accordBailleur;
    map['libelle'] = _libelle;
    map['verif_accord_bailleur'] = _verifAccordBailleur;
    map['cout'] = _cout;
    map['loyer_augmentera'] = _loyerAugmentera;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['propertytype_id'] = _propertytypeId;
    map['setcountry_id'] = _setcountryId;
    map['city_id'] = _cityId;
    map['quartier_id'] = _quartierId;
    map['user_id'] = _userId;
    map['liststatut_id'] = _liststatutId;
    map['emergencylevel_id'] = _emergencylevelId;
    if (_propertytype != null) {
      map['propertytype'] = _propertytype?.toJson();
    }
    if (_setcountry != null) {
      map['setcountry'] = _setcountry?.toJson();
    }
    if (_city != null) {
      map['city'] = _city?.toJson();
    }
    if (_quartier != null) {
      map['quartier'] = _quartier?.toJson();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['liststatut'] = _liststatut;
    if (_emergencylevel != null) {
      map['emergencylevel'] = _emergencylevel?.toJson();
    }
    if (_releasegoodconvenience != null) {
      map['releasegoodconvenience'] =
          _releasegoodconvenience?.map((v) => v.toJson()).toList();
    } else {
      map['releasegoodconvenience'] = [];
    }
    return map;
  }
}

/// id : 169
/// created_at : "2022-12-06 14:22:47"
/// updated_at : "2022-12-06 14:22:47"
/// deleted_at : null
/// releasegood_id : 47
/// conveniencetype_id : 6
/// number : 2
/// conveniencetype : {"id":6,"intitule":"Garage","created_at":"2022-09-30 07:05:33","updated_at":"2022-09-30 07:05:33","deleted_at":null,"morethanone":1}

class Releasegoodconvenience {
  Releasegoodconvenience({
    dynamic id,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic releasegoodId,
    dynamic conveniencetypeId,
    dynamic number,
    Conveniencetype? conveniencetype,
  }) {
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _releasegoodId = releasegoodId;
    _conveniencetypeId = conveniencetypeId;
    _number = number;
    _conveniencetype = conveniencetype;
  }

  Releasegoodconvenience.fromJson(dynamic json) {
    _id = json['id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _releasegoodId = json['releasegood_id'];
    _conveniencetypeId = json['conveniencetype_id'];
    _number = json['number'];
    _conveniencetype = json['conveniencetype'] != null
        ? Conveniencetype.fromJson(json['conveniencetype'])
        : null;
  }

  dynamic _id;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  dynamic _releasegoodId;
  dynamic _conveniencetypeId;
  dynamic _number;
  Conveniencetype? _conveniencetype;

  Releasegoodconvenience copyWith({
    dynamic id,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic releasegoodId,
    dynamic conveniencetypeId,
    dynamic number,
    Conveniencetype? conveniencetype,
  }) =>
      Releasegoodconvenience(
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        releasegoodId: releasegoodId ?? _releasegoodId,
        conveniencetypeId: conveniencetypeId ?? _conveniencetypeId,
        number: number ?? _number,
        conveniencetype: conveniencetype ?? _conveniencetype,
      );

  dynamic get id => _id;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  dynamic get releasegoodId => _releasegoodId;

  dynamic get conveniencetypeId => _conveniencetypeId;

  dynamic get number => _number;

  Conveniencetype? get conveniencetype => _conveniencetype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['releasegood_id'] = _releasegoodId;
    map['conveniencetype_id'] = _conveniencetypeId;
    map['number'] = _number;
    if (_conveniencetype != null) {
      map['conveniencetype'] = _conveniencetype?.toJson();
    }
    return map;
  }
}

/// id : 6
/// intitule : "Garage"
/// created_at : "2022-09-30 07:05:33"
/// updated_at : "2022-09-30 07:05:33"
/// deleted_at : null
/// morethanone : 1

class Conveniencetype {
  Conveniencetype({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic morethanone,
  }) {
    _id = id;
    _intitule = intitule;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _morethanone = morethanone;
  }

  Conveniencetype.fromJson(dynamic json) {
    _id = json['id'];
    _intitule = json['intitule'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _morethanone = json['morethanone'];
  }

  dynamic _id;
  dynamic _intitule;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  dynamic _morethanone;

  Conveniencetype copyWith({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic morethanone,
  }) =>
      Conveniencetype(
        id: id ?? _id,
        intitule: intitule ?? _intitule,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        morethanone: morethanone ?? _morethanone,
      );

  dynamic get id => _id;

  dynamic get intitule => _intitule;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  dynamic get morethanone => _morethanone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['intitule'] = _intitule;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['morethanone'] = _morethanone;
    return map;
  }
}

/// id : 1
/// intitule : "Normal"
/// created_at : "2022-10-05 05:14:46"
/// updated_at : "2022-10-05 05:14:46"
/// deleted_at : null

class Emergencylevel {
  Emergencylevel({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _intitule = intitule;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Emergencylevel.fromJson(dynamic json) {
    _id = json['id'];
    _intitule = json['intitule'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }

  dynamic _id;
  dynamic _intitule;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  Emergencylevel copyWith({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) =>
      Emergencylevel(
        id: id ?? _id,
        intitule: intitule ?? _intitule,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
      );

  dynamic get id => _id;

  dynamic get intitule => _intitule;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

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

/// id : 33
/// name : "Kesseni"
/// email : "kesseni1@yahoo.fr"
/// email_verified_at : null
/// verified : 0
/// verified_at : null
/// verification_token : null
/// two_factor : 0
/// nom : null
/// prenoms : null
/// phone : "66317070"
/// username : "Kesseni"
/// set_countries_id : 1
/// two_factor_expires_at : null
/// created_at : "2022-11-17 13:26:48"
/// updated_at : "2022-11-17 13:26:48"
/// deleted_at : null
/// profil : null
/// media : []

class User {
  User({
    dynamic id,
    dynamic name,
    dynamic email,
    dynamic emailVerifiedAt,
    dynamic verified,
    dynamic verifiedAt,
    dynamic verificationToken,
    dynamic twoFactor,
    dynamic nom,
    dynamic prenoms,
    dynamic phone,
    dynamic username,
    dynamic setCountriesId,
    dynamic twoFactorExpiresAt,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic profil,
    List<dynamic>? media,
  }) {
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
    _media = media;
  }

  User.fromJson(dynamic json) {
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
    /* if (json['media'] != null) {
      _media = [];
      json['media'].forEach((v) {
        _media?.add(Dynamic.fromJson(v));
      });
    }*/
  }

  dynamic _id;
  dynamic _name;
  dynamic _email;
  dynamic _emailVerifiedAt;
  dynamic _verified;
  dynamic _verifiedAt;
  dynamic _verificationToken;
  dynamic _twoFactor;
  dynamic _nom;
  dynamic _prenoms;
  dynamic _phone;
  dynamic _username;
  dynamic _setCountriesId;
  dynamic _twoFactorExpiresAt;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  dynamic _profil;
  List<dynamic>? _media;

  User copyWith({
    dynamic id,
    dynamic name,
    dynamic email,
    dynamic emailVerifiedAt,
    dynamic verified,
    dynamic verifiedAt,
    dynamic verificationToken,
    dynamic twoFactor,
    dynamic nom,
    dynamic prenoms,
    dynamic phone,
    dynamic username,
    dynamic setCountriesId,
    dynamic twoFactorExpiresAt,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic profil,
    List<dynamic>? media,
  }) =>
      User(
        id: id ?? _id,
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
        media: media ?? _media,
      );

  dynamic get id => _id;

  dynamic get name => _name;

  dynamic get email => _email;

  dynamic get emailVerifiedAt => _emailVerifiedAt;

  dynamic get verified => _verified;

  dynamic get verifiedAt => _verifiedAt;

  dynamic get verificationToken => _verificationToken;

  dynamic get twoFactor => _twoFactor;

  dynamic get nom => _nom;

  dynamic get prenoms => _prenoms;

  dynamic get phone => _phone;

  dynamic get username => _username;

  dynamic get setCountriesId => _setCountriesId;

  dynamic get twoFactorExpiresAt => _twoFactorExpiresAt;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  dynamic get profil => _profil;

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
    if (_media != null) {
      map['media'] = _media?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 7
/// intitule : "Samandin"
/// created_at : null
/// updated_at : null
/// deleted_at : null
/// set_countries_id : 1
/// city_id : 1

class Quartier {
  Quartier({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic setCountriesId,
    dynamic cityId,
  }) {
    _id = id;
    _intitule = intitule;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _setCountriesId = setCountriesId;
    _cityId = cityId;
  }

  Quartier.fromJson(dynamic json) {
    _id = json['id'];
    _intitule = json['intitule'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _setCountriesId = json['set_countries_id'];
    _cityId = json['city_id'];
  }

  dynamic _id;
  dynamic _intitule;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  dynamic _setCountriesId;
  dynamic _cityId;

  Quartier copyWith({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic setCountriesId,
    dynamic cityId,
  }) =>
      Quartier(
        id: id ?? _id,
        intitule: intitule ?? _intitule,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        setCountriesId: setCountriesId ?? _setCountriesId,
        cityId: cityId ?? _cityId,
      );

  dynamic get id => _id;

  dynamic get intitule => _intitule;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  dynamic get setCountriesId => _setCountriesId;

  dynamic get cityId => _cityId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['intitule'] = _intitule;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['set_countries_id'] = _setCountriesId;
    map['city_id'] = _cityId;
    return map;
  }
}

/// id : 1
/// intitule : "Ouagadougou"
/// created_at : "2022-10-02 09:34:48"
/// updated_at : "2022-10-02 09:34:48"
/// deleted_at : null
/// set_countries_id : 1

class City {
  City({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic setCountriesId,
  }) {
    _id = id;
    _intitule = intitule;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _setCountriesId = setCountriesId;
  }

  City.fromJson(dynamic json) {
    _id = json['id'];
    _intitule = json['intitule'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _setCountriesId = json['set_countries_id'];
  }

  dynamic _id;
  dynamic _intitule;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  dynamic _setCountriesId;

  City copyWith({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
    dynamic setCountriesId,
  }) =>
      City(
        id: id ?? _id,
        intitule: intitule ?? _intitule,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        setCountriesId: setCountriesId ?? _setCountriesId,
      );

  dynamic get id => _id;

  dynamic get intitule => _intitule;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  dynamic get setCountriesId => _setCountriesId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['intitule'] = _intitule;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['set_countries_id'] = _setCountriesId;
    return map;
  }
}

/// id : 1
/// intitule : "Burkina Faso"
/// code : "BF"
/// prefix : "+226"
/// flag : "bf.png"
/// statut : "1"
/// created_at : "2022-10-02 20:24:51"
/// updated_at : "2022-10-02 20:25:23"
/// deleted_at : null

class Setcountry {
  Setcountry({
    dynamic id,
    dynamic intitule,
    dynamic code,
    dynamic prefix,
    dynamic flag,
    dynamic statut,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _intitule = intitule;
    _code = code;
    _prefix = prefix;
    _flag = flag;
    _statut = statut;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Setcountry.fromJson(dynamic json) {
    _id = json['id'];
    _intitule = json['intitule'];
    _code = json['code'];
    _prefix = json['prefix'];
    _flag = json['flag'];
    _statut = json['statut'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }

  dynamic _id;
  dynamic _intitule;
  dynamic _code;
  dynamic _prefix;
  dynamic _flag;
  dynamic _statut;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  Setcountry copyWith({
    dynamic id,
    dynamic intitule,
    dynamic code,
    dynamic prefix,
    dynamic flag,
    dynamic statut,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) =>
      Setcountry(
        id: id ?? _id,
        intitule: intitule ?? _intitule,
        code: code ?? _code,
        prefix: prefix ?? _prefix,
        flag: flag ?? _flag,
        statut: statut ?? _statut,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
      );

  dynamic get id => _id;

  dynamic get intitule => _intitule;

  dynamic get code => _code;

  dynamic get prefix => _prefix;

  dynamic get flag => _flag;

  dynamic get statut => _statut;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['intitule'] = _intitule;
    map['code'] = _code;
    map['prefix'] = _prefix;
    map['flag'] = _flag;
    map['statut'] = _statut;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    return map;
  }
}

/// id : 4
/// intitule : "maison"
/// created_at : "2022-09-30 04:23:21"
/// updated_at : "2022-09-30 04:35:24"
/// deleted_at : null

class Propertytype {
  Propertytype({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) {
    _id = id;
    _intitule = intitule;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Propertytype.fromJson(dynamic json) {
    _id = json['id'];
    _intitule = json['intitule'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }

  dynamic _id;
  dynamic _intitule;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  Propertytype copyWith({
    dynamic id,
    dynamic intitule,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) =>
      Propertytype(
        id: id ?? _id,
        intitule: intitule ?? _intitule,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
      );

  dynamic get id => _id;

  dynamic get intitule => _intitule;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

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

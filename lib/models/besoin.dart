import 'dart:convert';
import '../models/user.dart';
List<Besoin> addBesoinListFromJson(dynamic val)=> List<Besoin>.from(
    val.map((besoin) =>  Besoin.fromJson(besoin))
);
class Besoin{
  final int? id;
  final String description;
  final String? created_at;
  final User? user;
  final String? titre;
  Besoin({
    this.id,
    required this.description,
    this.created_at,
    this.user,
    this.titre
});
  factory Besoin.fromJson(Map<String, dynamic> json) => Besoin(
    id: json['id'],
    created_at: json['created_at'],
    description: json['description'],
    titre: json['titre'],
    user: User.userModelFromJson(json['user']),

  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
    'titre': titre,
    'user':user,
    'created_at': created_at,
  };
}


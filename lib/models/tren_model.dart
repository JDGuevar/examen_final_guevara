import 'dart:convert';

class TrenModel {
    String id;
    String nom;
    String descripcio;
    String foto;
    String ruedas;
    String vagones;

    TrenModel({
        required this.id,
        required this.nom,
        required this.descripcio,
        required this.foto,
        required this.ruedas,
        required this.vagones,
    });

    factory TrenModel.fromJson(String str) => TrenModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TrenModel.fromMap(Map<String, dynamic> json) => TrenModel(
        id: json["id"],
        nom: json["nom"],
        descripcio: json["descripcio"],
        foto: json["foto"],
        ruedas: json["ruedas"],
        vagones: json["vagones"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nom": nom,
        "descripcio": descripcio,
        "foto": foto,
        "ruedas": ruedas,
        "vagones": vagones,
    };
}

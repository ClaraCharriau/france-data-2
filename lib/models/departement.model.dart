class Departement {
    String nom;
    String code;
    String codeRegion;

    Departement({
        required this.nom,
        required this.code,
        required this.codeRegion,
    });

    factory Departement.fromJson(Map<String, dynamic> json) => Departement(
        nom: json["nom"],
        code: json["code"],
        codeRegion: json["codeRegion"],
    );

    Map<String, dynamic> toJson() => {
        "nom": nom,
        "code": code,
        "codeRegion": codeRegion,
    };
}
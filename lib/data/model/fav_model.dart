class FavModel {
  String id;
  String idUser;

  // Constructor
  FavModel({this.id = "", required this.idUser});

  factory FavModel.fromMap(Map<String, dynamic> map) {
    return FavModel(id: map['id'] ?? '', idUser: map['idUser'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'idUser': idUser};
  }
}

class RoomModel {
  String id;
  String name;

  RoomModel({required this.id, required this.name});

  RoomModel.fromJSON(Map<String, dynamic> json)
      :id = json['id'] ?? '',
        name = json['name'] ?? '';

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
  };
}

class ClassModel {
  String id;
  String group;

  ClassModel({required this.id, required this.group});

  ClassModel.fromJSON(Map<String, dynamic> json)
      :id = json['id'] ?? '',
        group = json['group'] ?? '';

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : group,
  };
}

class ToDo {
  late String description;
  late String Title;
  late String date;
  late String Id;
  ToDo({
    required this.Title,
    required this.description,
    required this.date,
    required this.Id,
  });
  ToDo.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? '';
    Title = json['Title'] ?? '';
    date = json['data'] ?? '';
    Id = json['Id'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['description'] = description;
    data['Title'] = Title;
    data['date'] = date;
    return data;
  }
}

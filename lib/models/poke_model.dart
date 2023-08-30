class PokeModel {
  final String name;
  final String imageUrl;
  final List<String> types;

  PokeModel({required this.name, required this.imageUrl, required this.types});

  factory PokeModel.fromJson(Map<String, dynamic> json) {
    List<String> typeList = [];
    if (json['types'] != null) {
      json['types'].forEach((v) {
        typeList.add(v['type']['name']);
      });
    }
    return PokeModel(
        name: json['name'], imageUrl: json['sprites']['front_default'], types: typeList);
  }
}

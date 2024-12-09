class Itemsmodel {
  String? name;
  String? Calories;

  Itemsmodel({this.name, this.Calories});

  factory Itemsmodel.fromJson(Map<String, dynamic> json) {
    return Itemsmodel(
      name: json['name'],
      Calories: json['nutrition']['Calories'],
    );
  }
}

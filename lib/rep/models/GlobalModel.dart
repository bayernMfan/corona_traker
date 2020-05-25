class GlobalModel {
  final newConfirmed;
  final totalConfirmed;
  final newDeaths;
  final totalDeaths;
  final newRecovered;
  final totalRecovered;

  GlobalModel(this.newConfirmed, this.totalConfirmed, this.newDeaths, this.totalDeaths, this.newRecovered, this.totalRecovered);

  factory GlobalModel.fromJson(Map<String, dynamic> json){
    return GlobalModel(
      json["NewConfirmed"],
      json["TotalConfirmed"],
      json["NewDeaths"],
      json["TotalDeaths"],
      json["NewRecovered"],
      json["TotalRecovered"]
    );
  }
}
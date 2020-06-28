class CountryModel {
  final newConfirmed;
  final totalConfirmed;
  final newDeaths;
  final totalDeaths;
  final newRecovered;
  final totalRecovered;

  CountryModel(this.newConfirmed, this.totalConfirmed, this.newDeaths, this.totalDeaths, this.newRecovered, this.totalRecovered);

  factory CountryModel.fromJson(Map<String, dynamic> json){
    return CountryModel(
      json["NewConfirmed"],
      json["TotalConfirmed"],
      json["NewDeaths"],
      json["TotalDeaths"],
      json["NewRecovered"],
      json["TotalRecovered"]
    );
  }
}
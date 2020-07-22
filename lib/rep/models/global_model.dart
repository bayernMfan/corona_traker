import 'package:flutter/foundation.dart';

class GlobalModel {
  final String country;
  final String countryCode;
  final String slug;
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;

  GlobalModel({
    this.country,
    this.countryCode,
    this.slug,
    @required this.newConfirmed,
    @required this.totalConfirmed,
    @required this.newDeaths,
    @required this.totalDeaths,
    @required this.newRecovered,
    @required this.totalRecovered,
  })  : assert(newConfirmed != null),
        assert(totalConfirmed != null),
        assert(newDeaths != null),
        assert(totalDeaths != null),
        assert(newRecovered != null),
        assert(totalRecovered != null);

  factory GlobalModel.fromJson(Map<String, dynamic> json) {
    GlobalModel model = GlobalModel(
        country: json["Country"],
        countryCode: json["CountryCode"],
        slug: json["Slug"],
        newConfirmed: json["NewConfirmed"],
        totalConfirmed: json["TotalConfirmed"],
        newDeaths: json["NewDeaths"],
        totalDeaths: json["TotalDeaths"],
        newRecovered: json["NewRecovered"],
        totalRecovered: json["TotalRecovered"]);
    return model;
  }
}

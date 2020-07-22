import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider_app/rep/models/country_model.dart';

enum Prop { country, slug, iso2 }

class Country {
  Future<List<CountryModel>> getCountriesList() async {
    try {
      final result =
          await http.Client().get('https://api.covid19api.com/countries');
      List<CountryModel> countries = [];

      if (result.statusCode == 200)
        for (var item in json.decode(result.body)) {
          countries.add(CountryModel.fromJson(item));
        }
      return countries;
    } catch (exception) {
      throw exception;
    }
  }

  Future<List<String>> getCountriesParams([prop]) async {
    try {
      final result =
          await http.Client().get('https://api.covid19api.com/countries');
      List<String> countriesProp = ['World'];

      if (result.statusCode == 200)
        for (var item in json.decode(result.body)) {
          countriesProp.add(item[prop]);
        }
      return countriesProp;
    } catch (exception) {
      throw exception;
    }
  }
}

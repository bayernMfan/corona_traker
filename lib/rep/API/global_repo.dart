import 'package:http/http.dart' as http;
import 'package:provider_app/rep/models/global_model.dart';
import 'dart:convert';

class GlobalRepo {
  Future<GlobalModel> getGlobal([String country]) async {
    try {
      final result =
          await http.Client().get('https://api.covid19api.com/summary');

      if (result.statusCode == 200) {
        if (country != null) {
          return extract(result.body, "Countries", country);
        } else {
          return extract(result.body, "Global");
        }
      }
      // return GlobalModel(
      //   country: "test",
      //   countryCode: "test",
      //   slug: "test",
      //   totalConfirmed: 123,
      //   newConfirmed: 12,
      //   totalDeaths: 100,
      //   newDeaths: 10,
      //   totalRecovered: 50,
      //   newRecovered: 5,
      // );
    } catch (exception) {
      throw exception;
    }
  }

  GlobalModel extract(final data, String category, [String country]) {
    final _jsonDecodedData = json.decode(data);
    print("all decoded data = ${_jsonDecodedData.length}");
    final _globalInfo = _jsonDecodedData[category];
    print("in category Countries = ${_globalInfo.length}");
    if (country != null) {
      int id = _globalInfo
          .indexWhere((item) => item["Country"].toString() == country);
      return GlobalModel.fromJson(_globalInfo[id]);
    } else
      return GlobalModel.fromJson(_globalInfo);
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';


class Country {
  
}
// class GlobalRepo {
//   Future<GlobalModel> getGlobal() async{
//     final result = await http.Client().get('https://api.covid19api.com/summary');

//     if(result.statusCode != 200)
//       throw Exception();
    
//     else return extractGlobalFromAll(result.body);
//   }

//   GlobalModel extractGlobalFromAll(final data){
//     final jsonDecodedData = json.decode(data);
//     final globalInfo = jsonDecodedData["Global"];
//     return GlobalModel.fromJson(globalInfo);
//   }
// }
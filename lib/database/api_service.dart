import 'package:http/http.dart' as http;
import 'contsen.dart';

import 'city_model.dart';

class ApiService {
  Future<List<CityModel>>? getcity() async {
    try {
      var url = Uri.parse(ApiConstants().url + ApiConstants().enpoint);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<CityModel> model = userModelFromJson(response.body)!;
        return model;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
  };
}

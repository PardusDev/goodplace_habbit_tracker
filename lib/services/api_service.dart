
import 'package:dio/dio.dart';

class ApiService {
  String path = "https://api.quotable.io";

  getMotivation() async {
    var response = await Dio().get('$path/random', queryParameters: {'tags': 'happiness'});
    return response.data['content'];
  }
}
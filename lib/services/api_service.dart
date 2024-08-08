
import 'package:dio/dio.dart';

class ApiService {
  String yol = "https://api.quotable.io";

  getMotivasyon()async {
var response = await Dio().get('https://api.quotable.io/random', queryParameters: {'tags': 'happiness'});
return response.data['content'];
  }




 
}
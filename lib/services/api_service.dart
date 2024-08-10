
import 'package:dio/dio.dart';
import 'package:goodplace_habbit_tracker/core/exceptions/handle_dio_exception.dart';

class ApiService {
  String path = "https://api.quotable.io";

  getMotivation() async {
    try {
      var response = await Dio().get('$path/random', queryParameters: {'tags': 'happiness'});
      return response.data['content'];
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      throw e;
    }
  }
}
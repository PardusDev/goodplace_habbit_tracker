import 'package:goodplace_habbit_tracker/locator.dart';
import 'package:goodplace_habbit_tracker/services/api_service.dart';

class Repository {
  final ApiService _apiService = locator<ApiService>();

  getMotivasyon() async{
   return await _apiService.getMotivation();
  }

}
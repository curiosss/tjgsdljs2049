import 'package:dio/dio.dart';
import 'package:hotel/config/constants/app_constants.dart';

class NetworkService {
  Dio httpClient = Dio();

  NetworkService() {
    init();
  }

  init() {
    httpClient.options.baseUrl = AppConstants.baseUrl;
  }
}

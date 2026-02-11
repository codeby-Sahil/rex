import 'package:dio_get/core/network/api_client.dart';

class ApiService {
  final ApiClient apiClient = ApiClient();
  get dio => apiClient.dio;
}

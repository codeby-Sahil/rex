import 'package:prosnap/core/network/api_client.dart';

class ApiService {
  final ApiClient apiClient = ApiClient();
  get dio => apiClient.dio;
}

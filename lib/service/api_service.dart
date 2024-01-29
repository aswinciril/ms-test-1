import 'package:dio/dio.dart';

class NetworkApiService {
  Dio dio = Dio();

  Future<Response?> getDishList(String url) async {
    final response = await dio.get(url);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response;
    }
    return null;
  }
}

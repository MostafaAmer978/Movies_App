import 'package:dio/dio.dart';
import 'package:movies_app/core/utiles/constants.dart';

class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio();
  }

  /// Singleton Pattern
  // static ApiManager? instanceApiManager;
  //
  // static ApiManager getInstance() {
  //   instanceApiManager ??= ApiManager();
  //   return instanceApiManager!;
  // }

  Future<Response> getData(String endPoint,
      {Map<String, dynamic>? parameter}) async {
    try {
      Response response = await dio.get(Constants.baseURL + endPoint,
          options: Options(headers: {"Authorization": Constants.authorization}),
          queryParameters: parameter);
      return response;
    } catch (e) {
      throw Exception("Failed to GetData : ${e.toString()}");
    }
  }

  Future<Response> postData(String endpoint, {Map<String, dynamic>? body}) {
    return dio.post(Constants.baseURL + endpoint,
        options: Options(headers: {"Authorization": Constants.authorization}),
        data: body);
  }
}

import 'package:dio/dio.dart';
import 'package:to_do/service/shared_preference_storage.dart';
import 'package:to_do/utils/constants/api_constants.dart';
import 'package:to_do/utils/constants/store_keys.dart';

class DioClient {

  static final Dio dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    headers: {
      "apikey": ApiConstants.apiKey,
      "Content-Type": "application/json",
    },
  ))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = SharedPreferenceStorage.getString(StoreKeys.accessToken);
          if (accessToken.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshed = await _refreshToken();
            if (refreshed) {
              final newAccessToken =
              SharedPreferenceStorage.getString(StoreKeys.accessToken);

              final opts = error.requestOptions;
              opts.headers["Authorization"] = "Bearer $newAccessToken";

              try {
                final retryResponse = await dio.fetch(opts);
                return handler.resolve(retryResponse);
              } catch (e) {
                return handler.reject(e as DioException);
              }
            }
          }
          return handler.next(error);
        },
      ),
    );

  static Future<bool> _refreshToken() async {
    final refreshToken =
    SharedPreferenceStorage.getString(StoreKeys.refreshToken);

    try {
      final response = await Dio().post(
        "${ApiConstants.baseUrl}/auth/v1/token?grant_type=refresh_token",
        options: Options(headers: {
          "apikey": ApiConstants.apiKey,
          "Content-Type": "application/json",
        }),
        data: {"refresh_token": refreshToken},
      );

      print("/auth/v1/token?grant_type=refresh_token");
      print(response.statusCode);
      print(response.data);

      final data = response.data;
      await SharedPreferenceStorage.setString(
          key: StoreKeys.accessToken, value: data["access_token"]);
      await SharedPreferenceStorage.setString(
          key: StoreKeys.refreshToken, value: data["refresh_token"]);
      return true;
    } catch (e) {
      print("🔁 Refresh token xatolik: $e");
      return false;
    }
  }
}

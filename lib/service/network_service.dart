import 'package:to_do/models/login_model.dart';
import 'package:to_do/models/login_params.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/models/task_params.dart';
import 'package:to_do/service/dio_client.dart';
import 'package:to_do/service/shared_preference_storage.dart';
import 'package:to_do/utils/constants/api_constants.dart';
import 'package:to_do/utils/constants/store_keys.dart';

class NetworkService {
  static const String baseUrl = "https://crpfcilljvmbentfeijy.supabase.co";
  static String get refreshToken => SharedPreferenceStorage.getString(StoreKeys.refreshToken);
  static String get accessToken => SharedPreferenceStorage.getString(StoreKeys.accessToken);



  static Future<List<TaskModel>> getTask() async {
    try {
      final response = await DioClient.dio.get(ApiConstants.taskApi);
      final data = response.data;
      return (data as List).map((json) => TaskModel.fromJson(json)).toList();
    } catch (e) {
      print("getTask error: $e");
      throw Exception();
    }
  }

  static Future<bool> deleteTask(int id) async {
    try {
      final response = await DioClient.dio.delete("${ApiConstants.deleteApi}$id");
      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      print("deleteTask error: $e");
      throw Exception();
    }
  }

  static Future<bool> createTask(TaskParams params) async {
    try {
      final response = await DioClient.dio.post(
        ApiConstants.createApi,
        data: {
          "title": params.title,
          "description": params.description,
          "is_done": false,
        },
      );

      print(ApiConstants.createApi);
      print(response.statusCode);
      print(response.data);

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      print("createTask error: $e");
      throw Exception();
    }
  }

  static Future<bool> updateTask(int id, bool isDone) async {
    try {
      final response = await DioClient.dio.patch(
        "${ApiConstants.updateApi}$id",
        data: {"is_done": isDone},
      );

      print(ApiConstants.updateApi);
      print(response.statusCode);
      print(response.data);

      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      print("updateTask error: $e");
      throw Exception();
    }
  }

  static Future<LoginModel> login(LoginParams params) async {
    try {
      final response = await DioClient.dio.post(
        ApiConstants.loginApi,
        data: {
          "email": params.email,
          "password": params.password,
        },
      );
      print(ApiConstants.loginApi);
      print(response.statusCode);
      print(response.data);

      final data = response.data;
      await SharedPreferenceStorage.setString(
          key: StoreKeys.accessToken, value: data["access_token"]);
      await SharedPreferenceStorage.setString(
          key: StoreKeys.refreshToken, value: data["refresh_token"]);
      return LoginModel.fromJson(data);
    } catch (e) {
      print("Tarmoq xatosi: $e");
      throw Exception("Internet xatolik yoki noto'g'ri so'rov");
    }
  }

  static Future<bool> register(LoginParams params) async {
    try {
      final response = await DioClient.dio.post(
        ApiConstants.registerApi,
        data: {
          "email": params.email,
          "password": params.password,
        },
      );
      print(ApiConstants.registerApi);
      print(response.statusCode);
      print(response.data);
      return response.statusCode! >= 200 && response.statusCode! < 300;
    } catch (e) {
      print("Tarmoq xatosi: $e");
      throw Exception("Internet xatolik yoki noto'g'ri so'rov");
    }
  }
}

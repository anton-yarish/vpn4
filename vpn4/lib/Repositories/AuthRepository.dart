import '../Utils/AppUrls.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> login(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.loginUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> register(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.signUpUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> forgetPass(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.forgetPass, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> changePass(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrls.changePass, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

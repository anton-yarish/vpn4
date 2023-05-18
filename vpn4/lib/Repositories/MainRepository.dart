import '../Utils/AppUrls.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

class MainRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> fetchServers() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrls.allServers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

/*   Future<dynamic> fetchPublicIP() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrls.publicIPAddress);
      return response;
    } catch (e) {
      rethrow;
    }
  } */
}

import '/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../controllers/controller.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

class RolesRepo extends GetxService {
  final ApiClient apiClient;
  RolesRepo({required this.apiClient});
  Future<Response> getRoles() async {
    final token =  Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);

    return await apiClient.getData(AppConstants.GET_ROLES_URL);
  }
  Future<Response> addRole(RolesModel roleData) async{
    final token =  Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(AppConstants.ADD_ROLES_URL, roleData.toJson());
  }
  Future<Response> deleteTheRole(RolesModel roleData) async{
    final token =  Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(AppConstants.DELETE_ROLE_URL, roleData.toJson());
  }
}


import '../../../controllers/controller.dart';
import '/data/api/api_client.dart';
import '/models/auth_models/auth_model.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class RegistrationRepository extends GetxService{
  final ApiClient apiClient;
  RegistrationRepository({
    required this.apiClient,
});
  Future<Response> getRegisteredUsers() async{
    final token =  Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_REGISTERD_USERS);
  }
  Future<Response> registerNewUser(RegistrationModel registrationData) async{
    // final token =  Get.find<UserAuthController>().getUserToken();
    // apiClient.updateHeader(token!);
  return   await apiClient.postData(AppConstants.REGISTER_NEW_USER, registrationData.toJson());
  }
  Future<Response> deleteRegUser(RegistrationModel regUserData) async {
    final token =  Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(AppConstants.DELETE_REG_USER, regUserData.toJson());
  }
  Future<Response> assignRoleToRegUser(data) async {
    final token =  Get.find<UserAuthController>().getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.postData(AppConstants.ASSIGN_ROLE_TO_REG_USER, data);
  }
}
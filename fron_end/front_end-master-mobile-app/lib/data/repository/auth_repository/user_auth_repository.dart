import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/utils.dart';
import '../../api/api_client.dart';

class UserAuthRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserAuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
});

  Future<Response> login(data) async{
    return   await apiClient.postData(AppConstants.USER_LOGIN, data);
  }
  Future<Response> verifyEmail(String email) async{
    return await apiClient.postData(AppConstants.VERIFY_EMAIL, {'email':email});
  }
  Future<Response> getLoggedInUserInfo() async{
    final token =  getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_LOGGED_IN_USER_INFO,);
  }
  Future<Response> getAllUsers() async{
    final token =  getUserToken();
    apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_USERS_INFO,);
  }
  Future<Response> getAllFacultyMembers() async{
    // final token =  getUserToken();
    // apiClient.updateHeader(token!);
    return await apiClient.getData(AppConstants.GET_FACULTY_MEMBERS_URL);
  }
  bool userLoggedIn()   {
    return   sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  String? getUserToken()  {
    return  sharedPreferences.getString(AppConstants.TOKEN);
  }
  getUserAccountType()  {
    String accountType =  sharedPreferences.getString(AppConstants.ACCOUNT_TYPE)!.toLowerCase();
    return accountType;
  }
  getUserId()  {
    int userId = int.parse( sharedPreferences.getString(AppConstants.USER_ID.toString())!);
    return userId;
  }

  Future<bool> saveUserToken(String token) async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);

  }
  Future<void> saveUserEmailAndAccountType(String email,String accountType,int userId) async {
    try{
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
      await sharedPreferences.setString(AppConstants.ACCOUNT_TYPE, accountType);
      await sharedPreferences.setString(AppConstants.USER_ID.toString(), userId.toString());
    }catch(e){
      rethrow;
    }
  }

  bool logout() {
      sharedPreferences.remove(AppConstants.TOKEN);
      sharedPreferences.remove(AppConstants.ACCOUNT_TYPE);
      sharedPreferences.remove(AppConstants.USER_EMAIL);
      sharedPreferences.remove(AppConstants.USER_ID.toString());
      apiClient.token = '';
      apiClient.updateHeader('');
      return true;
  }
}
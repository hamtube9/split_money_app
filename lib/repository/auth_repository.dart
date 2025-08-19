import 'package:split_money/cores/dio_client.dart';
import 'package:split_money/models/auth/auth_response.dart';
import 'package:split_money/models/model_base.dart';
import 'package:split_money/models/auth/register_response.dart';
import 'package:split_money/models/user/user.dart';
import 'package:split_money/utils/ApiConstants.dart';

abstract class AuthRepository{
  Future<ModelBase<LoginResponse?>> login(String email, String password);
  Future<dynamic> register(String email, String name, String password);
  Future<ModelBase> forgotPassword(String email);
  Future<ModelBase> changePassword(String email, String oldPassword, String newPassword);
}

class AuthRepositoryImpl implements AuthRepository {
  // Instance
  static late AuthRepositoryImpl _instance;

  AuthRepositoryImpl._internal();

  // Get instance
  static AuthRepositoryImpl get instance {
    _instance = AuthRepositoryImpl._internal();
    return _instance;
  }

  @override
  Future<ModelBase<LoginResponse?>> login(String email, String password) async {
    var responseData = ModelBase<LoginResponse?>();
    try{
      var res = await  DioClient().post(ApiConstants.login, {"email" : email, "password" : password});
      if(res != null){
        responseData.isSuccess = res["isSuccess"];
        responseData.message = res["message"];
        if(res["data"] != null){
          var data = LoginResponse.fromJson(res["data"]);
          responseData.data = data;
        }
      }
    }catch(e){
      responseData.message = e.toString();
    }
    return responseData;


  }

  @override
  Future<ModelBase<RegisterResponse?>> register(String email, String name, String password) async {
    var responseData = ModelBase<RegisterResponse?>();
    try{
      var res = await DioClient().post(ApiConstants.register, {"email" : email, "password" : password, "name" : name});
      if(res != null){
        responseData.isSuccess = res["isSuccess"];
        responseData.message = res["message"];
        if(res["data"] != null){
          var data = RegisterResponse.fromJson(res["data"]);
          responseData.data = data;
        }

      }
    }catch(e){
      responseData.message = e.toString();
    }
    return responseData;
  }

  @override
  Future<ModelBase> changePassword(String email, String oldPassword, String newPassword) async {
    var responseData = ModelBase<RegisterResponse?>();
    try{
      var res = await DioClient().post(ApiConstants.changePassword, {"email" : email, "oldPassword" : oldPassword, "newPassword" : newPassword});
      if(res != null){
        responseData.isSuccess = res["isSuccess"];
        responseData.message = res["message"];
      }
    }catch(e){
      responseData.message = e.toString();
    }
    return responseData;
  }

  @override
  Future<ModelBase> forgotPassword(String email) async {
    var responseData = ModelBase<RegisterResponse?>();
    try{
      var res = await DioClient().post(ApiConstants.resetPassword, {"email" : email,});
      if(res != null){
        responseData.isSuccess = res["isSuccess"];
        responseData.message = res["message"];
      }
    }catch(e){
      responseData.message = e.toString();
    }
    return responseData;
  }

}

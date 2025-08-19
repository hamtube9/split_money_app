import 'package:split_money/cores/dio_client.dart';
import 'package:split_money/models/user/user_stat.dart';
import 'package:split_money/utils/ApiConstants.dart';

import '../models/model_base.dart';

abstract class HomeRepository {
  Future<ModelBase<UserStat?>> getUserStat();
}

class HomeRepositoryImpl extends HomeRepository {
  // Instance
  static late HomeRepositoryImpl _instance;

  HomeRepositoryImpl._internal();

  // Get instance
  static HomeRepositoryImpl get instance {
    _instance = HomeRepositoryImpl._internal();
    return _instance;
  }

  @override
  Future<ModelBase<UserStat?>> getUserStat() async  {
    var responseData = ModelBase<UserStat?>();
    try{
      var res = await  DioClient().get(ApiConstants.userStat);
      if(res != null){
        responseData.isSuccess = res["isSuccess"];
        responseData.message = res["message"];
        if(res["data"] != null){
          var data = UserStat.fromJson(res["data"]);
          responseData.data = data;
        }
      }
    }catch(e){
      responseData.message = e.toString();
    }
    return responseData;
  }

}
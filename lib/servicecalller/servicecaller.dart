import 'package:dio/dio.dart';
import 'package:imperoitdemo/Global/interceptor.dart';
import 'package:imperoitdemo/models/parentcategorymodel.dart' as Parent;
import 'package:imperoitdemo/models/subcategorymodel.dart';

class ServiceCaller{
  getParentcatlist(int pageindex)   async{
    Dio dio = await getInterceptors();
    Response response;
    try {
      response =  await dio.post(
          "http://esptiles.imperoserver.in/api/API/Product/DashBoard",data:  {'CategoryId':0,'DeviceManufacturer':"Google",'DeviceModel':'Android SDK built for x86','DeviceToken':'','PageIndex':pageindex},

      );

      return Parent.ParentCategoryModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("Course service caller error "+message);
      throw (message);
    }
  }
///get SubCatList
  getSubCatList(Parent.Category category, int pageindex)   async{
    Dio dio = await getInterceptors();
    Response response;
    try {
      response =  await dio.post(
        "http://esptiles.imperoserver.in/api/API/Product/DashBoard",data:  {'CategoryId':category.id,'PageIndex':pageindex},

      );

      return SubCategoryModel.fromJson(response.data);
    } on DioError catch(error){
      String message = error.message;
      print("Course service caller error "+message);
      throw (message);
    }
  }
}
import 'package:imperoitdemo/models/parentcategorymodel.dart' as Parent;
import 'package:imperoitdemo/models/subcategorymodel.dart';
import 'package:imperoitdemo/servicecalller/servicecaller.dart';
import 'package:rxdart/rxdart.dart';

import '../commonutills.dart';

class DataBloc{
  final servicecaller = ServiceCaller();

  // Parent OBJECTS
  final parentCatServiceSubject = BehaviorSubject<Parent.ParentCategoryModel>();
  get parenttabDatas => parentCatServiceSubject.stream;

  //SubCategoryService
  final subCatServiceSubject = BehaviorSubject<SubCategoryModel>();
  get subcatDatas => subCatServiceSubject.stream;

  /// LOADING OBJECTS
  final _isLoadingStateController = BehaviorSubject<bool>();

  get isLoading => _isLoadingStateController.stream;








  getParentList(int pageindex) async {
    try {
      if (await CommonUtills.ConnectionStatus() == true) {
        _isLoadingStateController.sink.add(true);
        bool isLoading = _isLoadingStateController.value;
        /*if (isLoading != null && isLoading) {
          return;
        }*/
        Parent.ParentCategoryModel response = await servicecaller.getParentcatlist(pageindex);

        parentCatServiceSubject.sink.add(response);

        _isLoadingStateController.sink.add(false);


        return parentCatServiceSubject;
      } else {

        Parent.ParentCategoryModel response = Parent.ParentCategoryModel();
        response.status = 201;
        response.message = "Network not available";
        parentCatServiceSubject.sink.add(response);

        _isLoadingStateController.sink.add(false);
        return parentCatServiceSubject;
      }
    } catch (DioError) {
      print(DioError);
      Parent.ParentCategoryModel response = Parent.ParentCategoryModel();
      response.status = 201;
      response.message = "Network not available";
      parentCatServiceSubject.sink.add(response);

      _isLoadingStateController.sink.add(false);
      return parentCatServiceSubject;


    }
  }
  getSubCategoryList(Parent.Category category, int pageindex,{SubCategoryModel oldresponse}) async {
    try {
      if (await CommonUtills.ConnectionStatus() == true) {
        _isLoadingStateController.sink.add(true);
        bool isLoading = _isLoadingStateController.value;
        /*if (isLoading != null && isLoading) {
          return;
        }*/
        SubCategoryModel response = await servicecaller.getSubCatList(category,pageindex);
        if(subCatServiceSubject.hasValue){
          List<SubCategory> oldCategories=subCatServiceSubject.stream.value.result.category[0].subCategories;
          List<SubCategory> newCategories=response.result.category[0].subCategories;


          List<SubCategory> finallist=oldCategories+newCategories;
          SubCategoryModel rresponse = response;
          rresponse.result.category[0].subCategories=finallist;
          subCatServiceSubject.sink.add(rresponse);

        }
        else{
          subCatServiceSubject.sink.add(response);
        }



        _isLoadingStateController.sink.add(false);


        return subCatServiceSubject;
      } else {


        SubCategoryModel response = SubCategoryModel();
        response.status = 201;
        response.message = "Network not available";
        subCatServiceSubject.sink.add(response);

        _isLoadingStateController.sink.add(false);
        return subCatServiceSubject;
      }
    } catch (DioError) {
      print(DioError);
      if(subCatServiceSubject.hasValue){

        subCatServiceSubject;

      }
      else{
        SubCategoryModel response = SubCategoryModel();
        response.status = 201;
        response.message = "Network not available";
        subCatServiceSubject.sink.add(response);

        _isLoadingStateController.sink.add(false);
        return subCatServiceSubject;
      }



    }
  }



  dispose() {
    parentCatServiceSubject.close();
    subCatServiceSubject.close();
    _isLoadingStateController.close();
  }




}
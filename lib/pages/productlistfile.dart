import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperoitdemo/Global/mycolors.dart';
import 'package:imperoitdemo/blocs/bloc.dart';
import 'package:imperoitdemo/commonutills.dart';
import 'package:imperoitdemo/models/parentcategorymodel.dart' as Parent;
import 'package:imperoitdemo/models/subcategorymodel.dart';

import 'package:rxdart/rxdart.dart';

class ProductListFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductListFileState();
  }
}

class ProductListFileState extends State<ProductListFile>{

  DataBloc bloc=new DataBloc();
  int pageindex=1;
  bool isLoading = false;
  ScrollController _sc = new ScrollController();
  Parent.Category mastercategory;
  List<ScrollController> catpodlistcontroller=new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bloc.getParentList(pageindex);

    _sc.addListener(() {
      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
        pageindex++;
        setState(() {
          isLoading=true;

        });
        _callMySubCatList();


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      body:
      Container(height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
          child:
          Container(child: createTabs(),

          ))



      ,);

  }

  Widget createSubCatandProduct(Parent.Category category) {
    mastercategory=category;
    bloc.getSubCategoryList(category,pageindex);
    return Container(

        child: StreamBuilder<SubCategoryModel>(stream: bloc.subCatServiceSubject.stream,
          builder: (context, AsyncSnapshot<SubCategoryModel>snapshot) {
            if (snapshot.hasData) {if (snapshot.error == null && snapshot.data.status == 201) {
              return _buildErrorWidget(snapshot.data.message);
            }
            else if (snapshot.error == null && snapshot.data.result.category.length == 0) {
              return _buildErrorWidget(
                  "NoDataFound");
            }
            else if (snapshot.error != null || snapshot.data.result.category.length == 0) {
              return _buildErrorWidget(snapshot.error);
            }
            return _returnDynamicSubCategoryTabs(snapshot.data.result.category[0].subCategories);
            } else if (snapshot.hasError) {
              return
                _buildErrorWidget(
                    snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )




    );

  }




  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CommonUtills.CommonLoadingWidget()],
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, right: 0, left: 0),
              child: Text(error,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
            )
          ],
        ));
  }

  _returnDynamictabs(List<Parent.Category> category) {
    return
      DefaultTabController(

          length: category.length,

          initialIndex:1,

          child:
          new Scaffold(
              appBar: new AppBar(
                backgroundColor: MyColors.primaryColor,
                actions: [Icon(Icons.filter_alt_outlined,size: 22,),SizedBox(width:   5,),Icon(Icons.search,size: 22,),SizedBox(width: 15,)],

                bottom: showMytabs(category),
              ),
              body: Container(decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)) ),child: new TabBarView(
                children: List<Widget>.generate(category.length, (int index){

                  return  Container(child: category[index].id==56? createSubCatandProduct(category[index]):Center(child:Text(category[index].name,style: TextStyle(fontSize: 18),)));

                }),),)));






  }



  _returnDynamicSubCategoryTabs(List<SubCategory> subCategories) {

    return
      ListView.builder(
          controller: _sc,
          itemCount:subCategories.length+1,shrinkWrap: true,itemBuilder: (context,index){
        if (index == subCategories.length) {
          return _CircleProgressIndicator();
        } else {
          return
            Container( margin: EdgeInsets.only(left: 10,bottom: 10,right: 10,top: 10),child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              SizedBox(height: 15,),
              Text(subCategories[index].name,
                style: TextStyle(color: Colors.black,fontSize: 15),),
              SizedBox(height: 5,),
              Container(height: 130, child:

             ListView.builder(shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: subCategories[index].product.length,


                  itemBuilder: (context, podindex) {

                        return Column(children: [
                      Container(padding: EdgeInsets.all(5),
                        height: 110,
                        width: 140,
                        child:ClipRRect(
                            borderRadius: BorderRadius.circular(4.0), child:
                        Stack(children: [
                          FadeInImage.assetNetwork(
                            placeholder: CommonUtills.placeholder,
                            image: subCategories[index].product[podindex]
                                .imageName,
                            fit: BoxFit.cover,
                            height: 100,width: 130,
                          ),
                          Positioned(left: 6,top: 6,child:
                          Container(decoration: BoxDecoration(color: MyColors.tilecolor,borderRadius: BorderRadius.only(topRight: Radius.circular(3.00),topLeft: Radius.circular(3.00),bottomRight: Radius.circular(3.00),bottomLeft: Radius.circular(3.00))),
                            padding: EdgeInsets.only(top: 4,bottom: 4,left: 9,right: 9),
                            child: Text(subCategories[index].product[podindex].priceCode,style: TextStyle(color: Colors.white,fontSize: 8),),
                          ))
                        ],)),),
                      SizedBox(height: 1,),
                      Text(subCategories[index].product[podindex].name,style: TextStyle(fontSize: 10),)
                    ],);
                  })
              )
            ],));
        }});

  }

  _CircleProgressIndicator() {
    return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Opacity(
            opacity: isLoading ? 1.0 : 00,
            child: new CircularProgressIndicator(),
          ),
        ));
  }

  void _callMySubCatList()async {
    BehaviorSubject<SubCategoryModel> result= await   bloc.getSubCategoryList(mastercategory,pageindex);

    setState(() {
      isLoading=false;

    });
  }

  createTabs() {
    return StreamBuilder<Parent.ParentCategoryModel>(
      stream: bloc
          .parentCatServiceSubject.stream,
      builder: (context,
          AsyncSnapshot<Parent.ParentCategoryModel>snapshot) {
        if (snapshot.hasData) {
          if (snapshot.error == null && snapshot.data.status == 201) {
            return _buildErrorWidget(snapshot.data.message);
          } else if (snapshot.error == null && snapshot.data.result.category.length == 0) {
            return _buildErrorWidget("NoDataFound");
          }
          else if (snapshot.error != null && snapshot.data.status == 201)
          {
            return _buildErrorWidget(
                "NoDataFound");
          }
          else if (snapshot.error != null || snapshot.data.result.category.length == 0)
          {
            return _buildErrorWidget(snapshot.error);
          }
          return _returnDynamictabs(
              snapshot.data.result.category);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(
              snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  showMytabs(List<Parent.Category> category) {
    return new TabBar(
      isScrollable: true,
      indicatorColor: Colors.transparent,
      labelColor: Colors.white,
      unselectedLabelColor: MyColors.inactivetabtextcolor,
      labelStyle: TextStyle(fontSize: 15),
      unselectedLabelStyle: TextStyle(fontSize: 10),

      tabs: List<Widget>.generate(category.length, (int index){

        return new Text( category[index].name,style: TextStyle(fontSize: 18),);

      }),

    );
  }

  CallFunc() {}

  callFunction() {}

  pageData(int currentListSize) {}

}
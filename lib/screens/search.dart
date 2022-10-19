import 'package:dixie_direct/apis/bussiness_api.dart';
import 'package:dixie_direct/model/business_model.dart';
import 'package:dixie_direct/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import '../utils/constant.dart';
import 'business_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _searchController=TextEditingController();

  List<BusinessModel> searchResult=[];
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: AppBar().preferredSize.height,
              color: Styles.themeData(themeData.darkTheme, context).primaryColor,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                  ),
                  Expanded(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value)async{
                          print("changed $value");
                          if(value==""){
                            setState(() {
                              searchResult=[];
                            });
                          }
                          else{
                            setState(() {
                              isLoading=true;
                              searchResult=[];
                            });
                            await BusinessApi.getSearchResult(_searchController.text).then((value){
                              setState(() {
                                searchResult=value;
                                isLoading=false;
                              });
                            }).onError((error, stackTrace){
                              setState(() {
                                isLoading=false;
                              });
                              print("error ${error.toString()}");
                            });

                          }

                        },
                        controller: _searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search,color: Colors.white,),
                  )
                ],
              ),
            ),
            if (!isLoading)
              Expanded(
              child: searchResult.length>0?ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BusinessDetail(searchResult[index])));

                    },
                    leading:Image.network(searchResult[index].uagbFeaturedImageSrc!.full!.first,height: 50,),
                    title: Text(searchResult[index].title!.rendered!),
                  );
                },
              ):Center(
                child: Text("No Results"),
              ),
            )
            else
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),

          ],
        ),
      ),
    );
  }
}

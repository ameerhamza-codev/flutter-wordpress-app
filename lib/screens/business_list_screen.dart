import 'package:dixie_direct/apis/favourite_pref.dart';
import 'package:dixie_direct/model/business_model.dart';
import 'package:dixie_direct/model/category_model.dart';
import 'package:dixie_direct/screens/business_detail.dart';
import 'package:dixie_direct/utils/constant.dart';
import 'package:dixie_direct/widgets/favourite_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../apis/bussiness_api.dart';
import '../provider/theme_provider.dart';
import '../utils/theme_data.dart';

class BusinessListScreen extends StatefulWidget {
  CategoryModel category;

  BusinessListScreen(this.category);

  @override
  _BusinessListScreenState createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.themeData(themeData.darkTheme, context).primaryColor,
        title: Text(widget.category.name!.replaceAll("&amp;", "&")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<BusinessModel>>(
              future: BusinessApi.getBusinessInCategory(widget.category.id!),
              builder: (context,AsyncSnapshot<List<BusinessModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  if (snapshot.hasError) {
                    print("error ${snapshot.error}");
                    return  Center(
                      child: Text("Something went wrong ${snapshot.error}"),
                    );
                  }
                  else if (snapshot.data!.length==0) {
                    print("error ${snapshot.error}");
                    return const Center(
                      child: Text("No Businesses"),
                    );
                  }

                  else {

                    return GridView.builder(
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(

                            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.2),
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context,int index){
                          //snapshot.data![index].name! = snapshot.data![index].name!.replaceAll("GeeksForGeeks", "Geek!");
                          return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BusinessDetail(snapshot.data![index])));
                              },
                              child:Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Styles.themeData(themeData.darkTheme, context).primaryColor,width: 2),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot.data![index].uagbFeaturedImageSrc!.full!.first),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(snapshot.data![index].title!=null?snapshot.data![index].title!.rendered!:"${snapshot.data![index].id}",maxLines: 1,textAlign: TextAlign.center,style: TextStyle(fontSize:13,fontWeight: FontWeight.w300),),

                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: FavoriteWidget(snapshot.data![index].id!),
                                    ),
                                  )
                                ],
                              )
                          );
                        }
                    );
                  }
                }
              }
          ),
        ),
      ),
    );
  }
}

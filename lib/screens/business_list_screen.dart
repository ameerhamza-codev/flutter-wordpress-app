import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixie_direct/apis/sql_api.dart';
import 'package:dixie_direct/screens/business_detail.dart';
import 'package:dixie_direct/sql_model/business_sql_model.dart';
import 'package:dixie_direct/sql_model/category_sql_model.dart';
import 'package:dixie_direct/widgets/favourite_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../apis/bussiness_api.dart';
import '../provider/theme_provider.dart';
import '../utils/theme_data.dart';

class BusinessListScreen extends StatefulWidget {
  CategorySqlModel category;

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
          child: FutureBuilder<List<BusinessSqlModel>>(
              future: SqlApi.getBusinessInCategory(widget.category.categoryId!),
              builder: (context,AsyncSnapshot<List<BusinessSqlModel>> snapshot) {
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
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Styles.themeData(themeData.darkTheme, context).primaryColor,width: 2),
                                              /*image: DecorationImage(
                                                  image: NetworkImage(snapshot.data![index].uagbFeaturedImageSrc!.full!.first),
                                                  fit: BoxFit.cover
                                              )*/
                                          ),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fitWidth,
                                            imageUrl: snapshot.data![index].imageUrl!,
                                            placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(snapshot.data![index].name!,maxLines: 1,textAlign: TextAlign.center,style: TextStyle(fontSize:13,fontWeight: FontWeight.w300),),

                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: FavoriteWidget(snapshot.data![index].businessId!),
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

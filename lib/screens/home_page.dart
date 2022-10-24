import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixie_direct/apis/bussiness_api.dart';
import 'package:dixie_direct/apis/sql_api.dart';
import 'package:dixie_direct/model/category_model.dart';
import 'package:dixie_direct/screens/business_list_screen.dart';
import 'package:dixie_direct/sql_model/category_sql_model.dart';
import 'package:dixie_direct/utils/constant.dart';
import 'package:dixie_direct/utils/theme_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apis/api_calls.dart';
import '../provider/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            //Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width*0.7,),
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.9,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: homeImageUrl,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),

            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("   Must Present Actual Card For Discount!",style: TextStyle(color: Colors.grey,fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Divider(),
            Expanded(
              child: FutureBuilder<List<CategorySqlModel>>(
                  future: SqlApi.getCategories(),
                  builder: (context,AsyncSnapshot<List<CategorySqlModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else {
                      if (snapshot.hasError) {
                        print("error ${snapshot.error}");
                        return Center(
                          child: Text("Something went wrong ${snapshot.error}"),
                        );
                      }
                      else if (snapshot.data!.length==0) {
                        print("error ${snapshot.error}");
                        return const Center(
                          child: Text("No Categories"),
                        );
                      }

                      else {

                        return GridView.builder(
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(

                                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.4),
                                crossAxisSpacing: 10,
                                crossAxisCount: 4,
                                mainAxisSpacing: 10
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context,int index){
                              //snapshot.data![index].name! = snapshot.data![index].name!.replaceAll("GeeksForGeeks", "Geek!");
                              return InkWell(
                                onTap: ()async{
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BusinessListScreen(snapshot.data![index])));
                                },
                                child:Column(
                                  children: [

                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Styles.themeData(themeData.darkTheme, context).primaryColor,
                                          /*image: DecorationImage(
                                                          image: NetworkImage(imagesnap.data!),
                                                          fit: BoxFit.contain
                                                      )*/
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data![index].imageUrl!,
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(snapshot.data![index].name!.contains(" ")?snapshot.data![index].name!.substring(0, snapshot.data![index].name!.indexOf(' ')):snapshot.data![index].name!,maxLines: 1,textAlign: TextAlign.center,style: TextStyle(fontSize:12,fontWeight: FontWeight.w300),),

                                  ],
                                )
                              );
                            }
                        );
                      }
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:dixie_direct/apis/bussiness_api.dart';
import 'package:dixie_direct/model/category_model.dart';
import 'package:dixie_direct/screens/business_list_screen.dart';
import 'package:dixie_direct/utils/constant.dart';
import 'package:dixie_direct/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width*0.7,),
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(homeImageUrl),
                  fit: BoxFit.fitWidth
                )
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("   Dicover offers by category",style: TextStyle(color: Colors.grey,fontSize: 18),),
              ],
            ),
            SizedBox(height: 10,),
            Divider(),
            Expanded(
              child: FutureBuilder<List<CategoryModel>>(
                  future: BusinessApi.getCategories(),
                  builder: (context,AsyncSnapshot<List<CategoryModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else {
                      if (snapshot.hasError) {
                        print("error ${snapshot.error}");
                        return const Center(
                          child: Text("Something went wrong"),
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

                                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.2),
                                crossAxisSpacing: 10,
                                crossAxisCount: 4,
                                mainAxisSpacing: 10
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context,int index){
                              //snapshot.data![index].name! = snapshot.data![index].name!.replaceAll("GeeksForGeeks", "Geek!");
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BusinessListScreen(snapshot.data![index])));
                                },
                                child:Column(
                                  children: [

                                    Expanded(
                                      child: FutureBuilder<String>(
                                          future: BusinessApi.getCategoryImage(snapshot.data![index].acf!.icon!),
                                          builder: (context,AsyncSnapshot<String> imagesnap) {
                                            if (imagesnap.connectionState == ConnectionState.waiting) {
                                              return Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                            else {
                                              if (imagesnap.hasError) {
                                                print("error ${imagesnap.error}");
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: AssetImage("assets/images/placeholder.jpeg"),
                                                          fit: BoxFit.cover
                                                      )
                                                  ),
                                                );
                                              }


                                              else {

                                                return Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Styles.themeData(themeData.darkTheme, context).primaryColor,
                                                      image: DecorationImage(
                                                          image: NetworkImage(imagesnap.data!),
                                                          fit: BoxFit.contain
                                                      )
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(snapshot.data![index].name!.contains(" ")?snapshot.data![index].name!.substring(0, snapshot.data![index].name!.indexOf(' ')):snapshot.data![index].name!,maxLines: 1,textAlign: TextAlign.center,style: TextStyle(fontSize:13,fontWeight: FontWeight.w300),),

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

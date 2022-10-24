import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixie_direct/apis/sql_api.dart';
import 'package:dixie_direct/provider/favourite_provider.dart';
import 'package:dixie_direct/sql_model/business_sql_model.dart';
import 'package:dixie_direct/widgets/favourite_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apis/bussiness_api.dart';
import '../provider/theme_provider.dart';
import '../utils/constant.dart';
import '../utils/theme_data.dart';
import 'business_detail.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    final provider = Provider.of<FavouriteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.themeData(themeData.darkTheme, context).primaryColor,
        title: const Text("Favorites"),
      ),
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<BusinessSqlModel>>(
              future: SqlApi.getFavouriteBusinesses(provider.favorites),
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
                              child:Column(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Styles.themeData(themeData.darkTheme, context).primaryColor,width: 2),

                                          ),
                                          child:  CachedNetworkImage(
                                            fit: BoxFit.fitWidth,
                                            imageUrl: snapshot.data![index].imageUrl!,
                                            placeholder: (context, url) => Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: FavoriteWidget(snapshot.data![index].businessId!),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(snapshot.data![index].name!,maxLines: 1,textAlign: TextAlign.center,style: TextStyle(fontSize:13,fontWeight: FontWeight.w300),),

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

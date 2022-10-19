import 'package:dixie_direct/provider/favourite_provider.dart';
import 'package:dixie_direct/widgets/favourite_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apis/bussiness_api.dart';
import '../model/business_model.dart';
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
        title: const Text("Favourites"),
      ),
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<BusinessModel>>(
              future: BusinessApi.getFavouriteBusinesses(provider.favorites),
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
                              child:Column(
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Styles.themeData(themeData.darkTheme, context).primaryColor,width: 2),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot.data![index].uagbFeaturedImageSrc!.full!.first),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: FavoriteWidget(snapshot.data![index].id!),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(snapshot.data![index].title!=null?snapshot.data![index].title!.rendered!:"${snapshot.data![index].id}",maxLines: 1,textAlign: TextAlign.center,style: TextStyle(fontSize:13,fontWeight: FontWeight.w300),),

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

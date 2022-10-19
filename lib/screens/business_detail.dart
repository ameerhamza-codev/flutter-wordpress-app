import 'package:dixie_direct/model/offer_model.dart';
import 'package:dixie_direct/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../apis/bussiness_api.dart';
import '../model/business_model.dart';
import '../provider/theme_provider.dart';
import '../utils/theme_data.dart';
import '../widgets/favourite_widget.dart';

class BusinessDetail extends StatefulWidget {
  BusinessModel businessModel;

  BusinessDetail(this.businessModel);

  @override
  _BusinessDetailState createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.themeData(themeData.darkTheme, context).primaryColor,
        title: Text(widget.businessModel.title!.rendered!),
        actions: [
          FavoriteWidget(widget.businessModel.id!)
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Image.network(widget.businessModel.uagbFeaturedImageSrc!.full!.first,height: MediaQuery.of(context).size.height*0.15,),
            SizedBox(height: 20,),
            Text("Offer",style: TextStyle(fontSize:  22,fontWeight: FontWeight.w700,color: Colors.grey[700]),),
            SizedBox(height: 20,),
            FutureBuilder<List<OfferModel>>(
                future: BusinessApi.getOffers(widget.businessModel.id!),
                builder: (context,AsyncSnapshot<List<OfferModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else {
                    if (snapshot.hasError) {
                      print("error ${snapshot.error}");
                      return Center(
                        child: Text("Unable to fetch offer ${snapshot.error}"),
                      );
                    }
                    else if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text("No offer available"),
                      );
                    }

                    else {

                      return Column(
                        children: [
                          HtmlWidget(
                            snapshot.data!.first.content!.rendered!,
                            textStyle: TextStyle(fontSize: 14),

                          ),
                          SizedBox(height: 10,),
                          Image.network(snapshot.data!.first.uagbFeaturedImageSrc!.full!.first,height: MediaQuery.of(context).size.height*0.2,fit: BoxFit.cover,),
                        ],
                      );
                    }
                  }
                }
            ),
            SizedBox(height: 20,),
            Text("Details",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.grey[700]),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Address",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                InkWell(
                  onTap: (){
                    MapsLauncher.launchQuery('${widget.businessModel.acf!.locations!.first.address!}, ${widget.businessModel.acf!.locations!.first.address2!}, ${widget.businessModel.acf!.locations!.first.city}, ${widget.businessModel.acf!.locations!.first.state}  ${widget.businessModel.acf!.locations!.first.zip}');
                  },
                  child: Text("Show Direction",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Styles.themeData(themeData.darkTheme, context).primaryColor,decoration: TextDecoration.underline),),

                )
              ],
            ),
            SizedBox(height: 5,),
            Text('${widget.businessModel.acf!.locations!.first.address!}, ${widget.businessModel.acf!.locations!.first.address2!}, ${widget.businessModel.acf!.locations!.first.city}, ${widget.businessModel.acf!.locations!.first.state}  ${widget.businessModel.acf!.locations!.first.zip}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,),),
            SizedBox(height: 10,),
            Text("Phone",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
            SizedBox(height: 5,),
            Text('${widget.businessModel.acf!.locations!.first.phone}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,),),
            SizedBox(height: 10,),
            Text("Website",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
            SizedBox(height: 5,),
            InkWell(
              onTap: (){
                launchUrl(Uri.parse(widget.businessModel.link!));
              },
              child: Text('${widget.businessModel.link}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colors.blue,decoration: TextDecoration.underline),),

            )

          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixie_direct/model/offer_model.dart';
import 'package:dixie_direct/sql_model/business_sql_model.dart';
import 'package:dixie_direct/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../apis/bussiness_api.dart';
import '../provider/theme_provider.dart';
import '../utils/theme_data.dart';
import '../widgets/favourite_widget.dart';

class BusinessDetail extends StatefulWidget {
  BusinessSqlModel businessModel;

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
        title: Text(widget.businessModel.name!),
        actions: [
          FavoriteWidget(widget.businessModel.businessId!),
          SizedBox(width: 10,)
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            CachedNetworkImage(
              height: MediaQuery.of(context).size.height*0.2,
              fit: BoxFit.fitHeight,
              imageUrl: widget.businessModel.imageUrl!,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),

            SizedBox(height: 20,),
            Text("Offer",style: TextStyle(fontSize:  22,fontWeight: FontWeight.w700,color: Colors.grey[700]),),
            SizedBox(height: 20,),
            FutureBuilder<List<OfferModel>>(
                future: BusinessApi.getOffers(widget.businessModel.businessId!),
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
                    MapsLauncher.launchQuery('${widget.businessModel.address}');
                  },
                  child: Text("Show Direction",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Styles.themeData(themeData.darkTheme, context).primaryColor,decoration: TextDecoration.underline),),

                )
              ],
            ),
            SizedBox(height: 5,),
            Text('${widget.businessModel.address}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,),),
            SizedBox(height: 10,),
            Text("Phone",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
            SizedBox(height: 5,),
            InkWell(
              onTap: ()async{
                launch("tel://${widget.businessModel.contact!}");
                //await launchUrl(smsLaunchUri);
              },
              child: Text('${widget.businessModel.contact!}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,),),

            ),
            SizedBox(height: 10,),
            Text("Website",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
            SizedBox(height: 5,),
            InkWell(
              onTap: (){
                launchUrl(Uri.parse(widget.businessModel.website!));
              },
              child: Text(widget.businessModel.website==''?'N/A':'${widget.businessModel.website}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colors.blue,decoration: TextDecoration.underline),),

            )

          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixie_direct/sql_model/business_sql_model.dart';
import 'package:dixie_direct/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../apis/sql_api.dart';
import '../provider/theme_provider.dart';
import 'business_detail.dart';

class MapScreen extends StatefulWidget {

  @override
  State<MapScreen> createState() => MapScreenState();


}
  
class MapScreenState extends State<MapScreen> {
  List<BusinessSqlModel> businesses=[];
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex;
  final Set<Marker> markers = Set();
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading=true;
    });
    getUserCurrentCoordinates().then((value){
      print("cc ${value.first} ${value.last}");
      _kGooglePlex = CameraPosition(
        target: LatLng(value[0], value[1]),
        zoom: 15,
      );
    }).onError((error, stackTrace){
      _kGooglePlex = CameraPosition(
        target: LatLng(0, 0),
        zoom: 15,
      );
    });

    SqlApi.getAllBusiness().then((value)async{
      businesses=value;
      value.forEach((element) async{

        List<Location> locations=[];
        await locationFromAddress('${element.address}').then((value){
          if(value.isNotEmpty){
            locations=value;
            LatLng _center =  LatLng(locations.first.latitude, locations.first.longitude);
            markers.add(Marker( //add first marker
              markerId: MarkerId(element.businessId!.toString()),
              position: _center, //position of marker
              icon: BitmapDescriptor.defaultMarker, //Icon for Marker
            ));
          }
        }).onError((error, stackTrace){
          print("error ${error.toString()}");
        });


      });
      setState(() {
        isLoading=false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    return Scaffold(
      body: isLoading?
      Center(
        child: CircularProgressIndicator(),
      )
      :
      SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex!,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  style: TextStyle(color: Colors.black),
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
                suggestionsCallback: (pattern) async {
                  List<BusinessSqlModel> search=[];
                  businesses.forEach((element) {
                    if(element.name!.toLowerCase().trim().contains(pattern.toLowerCase().trim())){
                      search.add(element);
                    }
                  });
                  return search;
                },
                itemBuilder: (context, BusinessSqlModel suggestion) {
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BusinessDetail(suggestion)));

                    },
                    leading:CachedNetworkImage(
                      height: 50,
                      width: 50,
                      fit: BoxFit.fitHeight,
                      imageUrl: suggestion.imageUrl!,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(suggestion.name!),
                  );
                },
                onSuggestionSelected: (BusinessSqlModel suggestion) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusinessDetail(suggestion)));
                },
              ),
            )
          ],
        ),
      ),

    );
  }


}
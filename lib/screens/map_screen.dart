import 'dart:async';
import 'package:dixie_direct/apis/bussiness_api.dart';
import 'package:dixie_direct/model/business_model.dart';
import 'package:dixie_direct/utils/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import 'business_detail.dart';

class MapScreen extends StatefulWidget {

  @override
  State<MapScreen> createState() => MapScreenState();


}
  
class MapScreenState extends State<MapScreen> {
  List<BusinessModel> businesses=[];
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

    BusinessApi.getAllBusinesses().then((value)async{
      businesses=value;
      value.forEach((element) async{

        List<Location> locations=[];
        await locationFromAddress('${element.acf!.locations!.first.address!}, ${element.acf!.locations!.first.address2!}, ${element.acf!.locations!.first.city}, ${element.acf!.locations!.first.state}  ${element.acf!.locations!.first.zip}').then((value){
          if(value.isNotEmpty){
            locations=value;
            LatLng _center =  LatLng(locations.first.latitude, locations.first.longitude);
            markers.add(Marker( //add first marker
              markerId: MarkerId(element.id!.toString()),
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
                  List<BusinessModel> search=[];
                  businesses.forEach((element) {
                    if(element.title!.rendered!.toLowerCase().trim().contains(pattern.toLowerCase().trim())){
                      search.add(element);
                    }
                  });
                  return search;
                },
                itemBuilder: (context, BusinessModel suggestion) {
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  BusinessDetail(suggestion)));

                    },
                    leading:Image.network(suggestion.uagbFeaturedImageSrc!.full!.first,height: 50,),
                    title: Text(suggestion.title!.rendered!),
                  );
                },
                onSuggestionSelected: (BusinessModel suggestion) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BusinessDetail(suggestion)
                  ));
                },
              ),
            )
          ],
        ),
      ),

    );
  }


}
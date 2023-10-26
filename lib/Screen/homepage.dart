import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:to_do_list/APIS/apis.dart';
import 'package:to_do_list/GPS/gps.dart';
import 'package:to_do_list/Screen/addnote.dart';
import 'package:to_do_list/Screen/notepage.dart';
import 'package:to_do_list/Screen/temppage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _location;
  Map<String, dynamic>? _current;
  final Gps _gps = Gps();
  Position? userpostion;
  Exception? _exception;
  double? lat;
  double? longs;
  String address = "";

  Future<void> _handlePositionStream(Position position) async {
    setState(() {
      userpostion = position;
      lat = position.latitude;
      longs = position.longitude;
    });
    getAddress(position.latitude, position.longitude);
    _location = (await APIs.getAPIs(position.latitude, position.longitude))!;
    _current = (await APIs.getCurrent(position.latitude, position.longitude))!;
  }

  getAddress(lat, longs) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, longs);
    setState(() {
      address = placemarks[0].subLocality! +
          " " +
          placemarks[0].locality! +
          ", " +
          placemarks[0].country!;
    });
    // for (int i = 0; i < placemarks.length; i++) {
    //   print("INDEX $i ${placemarks[i]}");
    // }
  }

  @override
  void initState() {
    super.initState();
    _gps.startPositionStream(_handlePositionStream);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3AA6B9),
      floatingActionButton:  (_location == null && _current == null)?FloatingActionButton(onPressed: (){}):FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddNote(isUpdate: false,)));
        },
        child: Image.asset('Images/add.png'),
      ),
      body: (_location == null && _current == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.only(top: 40, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _location?['localtime'],
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                                image: AssetImage('Images/cloudy.png'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                                image: AssetImage('Images/sun (2).png'),
                                fit: BoxFit.cover)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _location?['name'],
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text(
                    _location?['country'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TempScreen(
                    temps: _current!,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                Column(children: [
                  NotePage()
                ],)
                ]),
              ),
            ),
    );
  }
}

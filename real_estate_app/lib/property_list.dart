import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_rent_buy_house/house_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:real_estate_app/landing.dart';
import 'package:real_estate_app/property_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 750),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20.0)) +
                    EdgeInsets.only(
                      top: ScreenUtil().setHeight(50.0),
                      bottom: ScreenUtil().setHeight(40.0),
                    ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Find your\n',
                      style: GoogleFonts.play(
                          color: Colors.grey,
                          fontSize: ScreenUtil().setSp(26.0)),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Perfect Home',
                          style: GoogleFonts.play(
                              color: Color(0xff442243),
                              fontSize: ScreenUtil().setSp(26.0),
                              fontWeight: FontWeight.w600),
                        )
                      ]),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey[300]!)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: ScreenUtil().setHeight(24.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                _nearbyHomes(
                    "https://image.freepik.com/free-photo/house-isolated-field_1303-23773.jpg",
                    "Luxurious Duplex Flat",
                    "328 Icaw Drive, 10001 NY",
                    "4",
                    "2"),
                _nearbyHomes(
                    "https://image.freepik.com/free-photo/interior-home-design-living-room-with-open-kitchen-loft-house_41487-613.jpg",
                    "Full Furnished Home",
                    "876 Wafaz Way, 10003 NY",
                    "3",
                    "2"),
                _nearbyHomes(
                    "https://image.freepik.com/free-photo/3d-rendering-luxury-modern-design-wood-building-near-park-nature-night-scene_105762-1045.jpg",
                    "Exclusive Flat",
                    "1453 Azaro Way, 10009 NY",
                    "2",
                    "1"),
                _nearbyHomes(
                    "https://image.freepik.com/free-photo/charming-yellow-house-with-wooden-windows-green-grassy-garden_181624-8074.jpg",
                    "Semi Furnished Home",
                    "619 Wafaz Way, 10003 NY",
                    "3",
                    "2"),
                _nearbyHomes(
                    "https://image.freepik.com/free-photo/house-isolated-field_1303-23773.jpg",
                    "Luxurious Duplex Flat",
                    "328 Icaw Drive, 10001 NY",
                    "4",
                    "2"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _nearbyHomes(String asset, String name, String location, String bedCount,
      String bathCount) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20.0)) +
          EdgeInsets.only(bottom: ScreenUtil().setHeight(20.0)),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HouseDetails()),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  asset,
                  fit: BoxFit.cover,
                  height: ScreenUtil().setHeight(100.0),
                  width: ScreenUtil().setWidth(100.0),
                )),
            SizedBox(
              width: ScreenUtil().setWidth(10.0),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.play(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(16.0),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5.0),
                ),
                Text(
                  location,
                  style: GoogleFonts.play(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(14.0),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5.0),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.king_bed,
                          color: Colors.grey,
                          size: ScreenUtil().setHeight(18.0),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(5.0),
                        ),
                        Text(
                          bedCount,
                          style: GoogleFonts.play(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(14.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(10.0),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.bathtub,
                          color: Colors.grey,
                          size: ScreenUtil().setHeight(16.0),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(5.0),
                        ),
                        Text(
                          bathCount,
                          style: GoogleFonts.play(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(14.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

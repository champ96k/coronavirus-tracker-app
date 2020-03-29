import 'dart:convert';
import 'package:covid19_tracker/ui/AllCountry.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index;
  var url = "https://corona.lmao.ninja/countries";
  var url1 = "https://corona.lmao.ninja/all";
  var data, allCountryData;
  Future getJsonData(url, url1) async {
    var responce = await http.get(Uri.encodeFull(url));
    var responceall = await http.get(Uri.encodeFull(url1));

    setState(() {
      var countryData = json.decode(responce.body);
      var allData = json.decode(responceall.body);
      data = countryData;
      allCountryData = allData;
    });
    debugPrint(responce.body);
    debugPrint(responceall.body);
  }

  @override
  void initState() {
    getJsonData(url, url1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (data == null && allCountryData == null)
        ? Center(
            child: FadingText(
              'Stay safe during the pandemic...',
              style: TextStyle(
                letterSpacing: 3.0,
              ),
            ),
          )
        : SingleChildScrollView(
            child: IntrinsicHeight(
              child: SafeArea(
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        color: Color(0xff4E01FD),
                        height: 235,   
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 32.0,
                                  right: 32.0, 
                                  top: 12.0, 
                              ), 
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Confirmed cases\n (total)",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 12.0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${allCountryData['cases']}",
                                  style: TextStyle(
                                      fontSize: 21.0, color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 12.0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Deaths\n (total)",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 12.0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${allCountryData['deaths']}",
                                  style: TextStyle(
                                      fontSize: 21.0, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          color: Color(0xff4E01FD),
                          height: 235,  
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image(
                              fit: BoxFit.fitWidth,
                              image: AssetImage("images/pic2.JPG"),
                            ),
                          )),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: Color(0xff4E01FD),
                      height: 280.0,
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 20),
                                  child: Text(
                                    "Most affected country",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 4),  
                                  child: FlatButton(
                                    onPressed: () {
                                      debugPrint("See all Botton Call");
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AllCountry()));
                                    },
                                    child: Text(
                                      "See all",
                                      style: TextStyle(
                                        color: Color(0xff9262FF),
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 200,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 8.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      color: Color(0xffF6F7F9),
                                      elevation: 2.0,
                                      child: Container(
                                        height: 90,
                                        width: 160,
                                        child: Column(
                                          children: <Widget>[
                                            ListTile(
                                              leading: Image(
                                                height: 30.0,
                                                width: 30.0,
                                                image: (data == null)
                                                    ? CircularProgressIndicator()
                                                    : NetworkImage(data[index]
                                                            ['countryInfo']
                                                        ['flag']),
                                              ),
                                              trailing: (data == null)
                                                  ? CircularProgressIndicator()
                                                  : Text(
                                                      data[index]['country'],
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.ac_unit,
                                                color: Colors.black87,
                                              ),
                                              trailing: (data == null)
                                                  ? CircularProgressIndicator()
                                                  : Text(
                                                      "${data[index]['cases']}",
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                            ),
                                            ListTile(
                                              leading: (data == null)
                                                  ? CircularProgressIndicator()
                                                  : Icon(
                                                      Icons
                                                          .airline_seat_individual_suite,
                                                      color: Colors.black87,
                                                    ),
                                              trailing: (data == null)
                                                  ? CircularProgressIndicator()
                                                  : Text(
                                                      "${data[index]['deaths']}",
                                                      style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, top: 22.0),
                        child: Text(
                          "Remember :",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Container(
                    height: 250.0,
                    child:
                        ListView(scrollDirection: Axis.horizontal, children: <
                            Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Row(children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Stack(
                              children: <Widget>[
                                Card(
                                  color: Color(0xff6C01FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    height: 185,
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Color(0xff6C01FF),
                                            height: 65,
                                            width: 65,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.0))),
                                              child: Image(
                                                fit: BoxFit.contain,
                                                image: AssetImage(
                                                    "images/pic1.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 12.0),
                                          child: Text(
                                            "Wash You'r hand",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.5,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Card(
                                        color: Color(0xff6C01FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          height: 185,
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: Color(0xff6C01FF),
                                                  height: 65,
                                                  width: 65,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Image(
                                                      fit: BoxFit.contain,
                                                      image: AssetImage(
                                                          "images/pic3.png"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 12.0),
                                                child: Text(
                                                  "Wear a mask",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.5,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Card(
                                        color: Color(0xff6C01FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          height: 185,
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: Color(0xff6C01FF),
                                                  height: 65,
                                                  width: 65,
                                                  child: Card(
                                                    //      color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Image(
                                                      fit: BoxFit.contain,
                                                      image: AssetImage(
                                                          "images/pic4.png"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 12.0),
                                                child: Text(
                                                  "Stop Touching your face",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.5,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Card(
                                        color: Color(0xff6C01FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          height: 185,
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: Color(0xff6C01FF),
                                                  height: 65,
                                                  width: 65,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Image(
                                                      fit: BoxFit.contain,
                                                      image: AssetImage(
                                                          "images/pic6.png"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 12.0),
                                                child: Text(
                                                  "Avoid handshakes and hugs",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.5,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Card(
                                        color: Color(0xff6C01FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          height: 185,
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: Color(0xff6C01FF),
                                                  height: 65,
                                                  width: 65,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Image(
                                                      fit: BoxFit.contain,
                                                      image: AssetImage(
                                                          "images/pic7.jpg"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 12.0),
                                                child: Text(
                                                  "Practice social distancing.",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.5,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Card(
                                        color: Color(0xff6C01FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Container(
                                          height: 185,
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  color: Color(0xff6C01FF),
                                                  height: 65,
                                                  width: 65,
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                    child: Image(
                                                      fit: BoxFit.contain,
                                                      image: AssetImage(
                                                          "images/pic8.jpg"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 12.0),
                                                child: Text(
                                                  "Cover your sneeze",
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.5,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  )),
                ]),
              ),
            ),
          );
  }
}

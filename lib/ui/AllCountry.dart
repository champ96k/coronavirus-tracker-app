import 'dart:convert';
import 'package:covid19_tracker/ui/CountryInfo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class AllCountry extends StatefulWidget {
  @override
  _AllCountryState createState() => _AllCountryState();
}

class _AllCountryState extends State<AllCountry> {
  int index;
  var url = "https://corona.lmao.ninja/countries";
  var data, allCountryData;
  Future getJsonData(url) async {
    var responce = await http.get(Uri.encodeFull(url));

    setState(() {
      var countryData = json.decode(responce.body);
      data = countryData;
    });
    debugPrint(responce.body);
  }

  @override
  void initState() {
    getJsonData(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Country"), 
      ),
      body: (data == null && allCountryData == null)
          ? Center(
              child: FadingText(
                'Stay safe during the pandemic...',
                style: TextStyle(
                  letterSpacing: 3.0,
                ),
              ),
            )
          : ListView.builder(
              itemCount: data.length, 
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryInfo(data,index)));
                  },
                  child: Card(
                    child: ListTile(
                      leading: Container(
                        height: 50,      
                        width: 70,  
                        color: Colors.deepPurpleAccent,
                        child: Image(
                         fit: BoxFit.cover,
                        image:NetworkImage(data[index]['countryInfo']['flag']),
                      ),
                      ),
                      title: Text(data[index]['country']),
                      subtitle: Text("Total Cases"),
                      trailing: Text("${data[index]['cases']}"), 
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryInfo extends StatefulWidget {
  var data, index;
  CountryInfo(this.data, this.index);

  @override
  _CountryInfoState createState() => _CountryInfoState(this.data, this.index);
}

class _CountryInfoState extends State<CountryInfo> {

  _launchURL() async {
  const url = 'https://www.who.int/emergencies/diseases/novel-coronavirus-2019';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


 _launchURL1() async {
  const url = 'https://www.worldometers.info/coronavirus/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  var data, index;
  _CountryInfoState(this.data, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data[index]['country']),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              color: Colors.redAccent,
              height: 60,
              width: 62,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(data[index]['countryInfo']['flag']),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: <Widget>[

        Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), 
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.grey[300],
                child: Container(
                    height: 100,
                    width: 155,
                    child: Center(
                      child: ListTile(
                        leading: Text("Total\nCases"),
                        trailing: Text("${data[index]['cases']}"),  
                      ),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), 
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.grey[300],
                child: Container(
                    height: 100,
                    width: 155,
                    child: Center(
                      child: ListTile(
                        leading: Text("Today\nCases"),
                        trailing: Text("${data[index]['todayCases']}"),
                      ),
                    )),
              ),
            ),
          ],
        ),


       Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), 
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.grey[300],
                child: Container(
                    height: 100,
                    width: 155,
                    child: Center(
                      child: ListTile(
                        leading: Text("Total\nDeaths"), 
                        trailing: Text("${data[index]['deaths']}"),
                      ),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), 
              child: Card( 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.grey[300],
                child: Container(
                    height: 100,
                    width: 155,
                    child: Center(
                      child: ListTile(
                        leading: Text("Today\nDeaths"), 
                        trailing: Text("${data[index]['todayDeaths']}"),
                      ),
                    )),
              ),
            ),
          ],
        ),

        Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), 
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.grey[300],
                child: Container(
                    height: 100,
                    width: 155,  
                    child: Center(
                      child: ListTile(
                        leading: Text("Total\nRecovered"), 
                        trailing: Text("${data[index]['recovered']}"),
                      ),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.grey[300],
                child: Container(
                    height: 100,
                    width: 155,
                    child: Center(
                      child: ListTile(
                        leading: Text("Active\nCases"),
                        trailing: Text("${data[index]['active']}"),
                      ),
                    )),
              ),
            ),
          ],
        ),


        Row(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0), 
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.grey[300],
                child: Container(
                    height: 100,
                    width: 155,  
                    child: Center(
                      child: ListTile(
                        leading: Text("Critical\nPatient"), 
                        trailing: Text("${data[index]['critical']}"), 
                      ),
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.grey[300],
                child: Container(
                    height: 100,
                    width: 155,
                    child: Center(
                      child: ListTile(
                        title: Center(child: Text("More Info")), 
                      ),
                    )),
              ),
            ),
          ],
        ),

        FlatButton(
          onPressed: (){
            _launchURL();
          },
         child: FlatButton(
           onPressed: () {
             _launchURL1();
           },
                    child: Text("Learn More",
           style: TextStyle(
             color: Colors.deepPurple,
           ),
           ),
         ),
        )

        

        
      ]),
    );
  }
}

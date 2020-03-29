import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Description extends StatefulWidget {
  var description, data, index;
  Description(this.data, this.index);

  @override
  _DescriptionState createState() => _DescriptionState(this.data, this.index);
}

class _DescriptionState extends State<Description> {
  var dataPage, indexPage;
  _DescriptionState(this.dataPage, this.indexPage);

  _launchURL() async {
    if (await canLaunch(dataPage[indexPage]['url'])) {
      await launch(dataPage[indexPage]['url']);
    } else {
      throw 'Could not launch ${dataPage[indexPage]['url']}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: double.infinity,
                  child: (dataPage[indexPage]['urlToImage'] == null)
                      ? Image(
                          image: NetworkImage(
                              'https://previews.123rf.com/images/njwatchara/njwatchara1806/njwatchara180600028/106272860-global-earth-rotating-digital-world-news-studio-background-for-news-report-and-breaking-news.jpg'))
                      : Image(
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(dataPage[indexPage]['urlToImage']),
                        ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              Share.share(dataPage[indexPage]['url']);
                            });
                          },
                          icon: Icon(Icons.share, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ListTile(
              leading: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Stay Home Stay Safe",
                    style: TextStyle(fontSize: 11.5, color: Colors.black),
                  ),
                ),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.bookmark_border), onPressed: null),
            ),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: (dataPage[indexPage]['title'] == null)
                      ? Text("Breking News")
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Text(
                              dataPage[indexPage]['title'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: (dataPage[indexPage]['content'] == null)
                    ? Text("sorry the content is not available now ")
                    : Text(
                        dataPage[indexPage]['content'],
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
            MaterialButton(
              height: MediaQuery.of(context).size.height * 0.05,
              minWidth: MediaQuery.of(context).size.width * 0.80,
              color: Colors.brown[300],  
              onPressed: () {
                _launchURL();
              },
              shape: StadiumBorder(),
              child: Text(
                "Read Full News",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

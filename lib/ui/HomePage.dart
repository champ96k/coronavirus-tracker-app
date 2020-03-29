import 'package:covid19_tracker/ui/HomeScreen.dart';
import 'package:covid19_tracker/ui/News.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  bodySelector() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return Health();
        break;
    } 
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: bodySelector(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chrome_reader_mode),
              title: Text('News'),
            ),
          ],
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.grey[500],
          selectedItemColor: Colors.red,
          showUnselectedLabels: true,
          onTap: (int i) {
            setState(() {
              _currentIndex = i;
            });
          },
        ),
      ),
    );
  }
}

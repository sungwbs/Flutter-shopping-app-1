import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:one/tabs/tab_cart.dart';
import 'package:one/tabs/tab_home.dart';
import 'package:one/tabs/tab_profile.dart';
import 'package:one/tabs/tab_search.dart';


class IndexScreen extends StatefulWidget {

  @override
  _IndexScreenState createState() {
    return _IndexScreenState();
  }
}

class _IndexScreenState extends State<IndexScreen> {

  int _currentIndex = 0;  // 변수 초기화 후, 인덱스 값으로 상호작용

  final List<Widget> tabs = [
    TabHome(),
    TabSearch(),
    TabCart(),
    TabProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 44,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // 해당 인덱스로 업데이트
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
      body: tabs[_currentIndex],
    );
  }
}
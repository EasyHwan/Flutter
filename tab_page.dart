import 'package:flutter/material.dart';
import 'package:instgram_clon/home_page.dart';
import 'package:instgram_clon/home_page.dart';
import 'package:instgram_clon/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'account_page.dart';

class TabPage extends StatefulWidget {
  late final User user;
  TabPage(this.user);
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  late List _pages;
  void initState(){
    super.initState();
    _pages = [
      HomePage(widget.user),
      SearchPage(widget.user),
      AccountPage(widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('Home')),
        BottomNavigationBarItem(icon: Icon(Icons.search),title: Text('Search')),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('Account')),
        ]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex=index;
    });
  }
}

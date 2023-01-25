import 'package:flutter/material.dart';
import 'package:potential/models/investor.dart';
import 'package:potential/utils/appTools.dart';

import '../models/cancreation.dart';
import '../screens/bottomTabs.dart';

class TabsPage extends StatefulWidget {
  int selectedIndex = 0;
  final Investor investorData;
  final CANIndFillEezzReq fillEezzReq;

  TabsPage(
      {super.key,
      required this.selectedIndex,
      required this.investorData,
      required this.fillEezzReq});

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    _onItemTapped(widget.selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String str = "#002450";
    return Scaffold(
      body: Scaffold(
        body: IndexedStack(
          index: widget.selectedIndex,
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
      ),
      backgroundColor: hexToColor(str),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: hexToColor(str),
        currentIndex: (_selectedIndex),
        selectedFontSize: 12,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 20),
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: IconThemeData(
          color: Colors.white70,
        ),
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        iconSize: 20,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_rounded),
            label: 'Invest',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_rounded),
            label: 'Goals',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/models/investor.dart';
import 'package:potential/utils/appTools.dart';

import '../models/cancreation.dart';
import '../screens/bottomTabs.dart';
import '../utils/styleConstants.dart';
import '../utils/track.dart';

class TabsPage extends StatefulWidget {
  int selectedIndex = 2;

  TabsPage({
    super.key,
    required this.selectedIndex,
  });

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      _selectedIndex = widget.selectedIndex;
      if (kDebugMode) {
        print(_selectedIndex);
      }
    });
  }

  @override
  void initState() {
    _onItemTapped(widget.selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String str = "#181818";
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: hexToColor(str),
            currentIndex: (_selectedIndex),
            selectedFontSize: 12,
            selectedIconTheme:
                const IconThemeData(color: Colors.white, size: 20),
            selectedItemColor: Colors.white,
            selectedLabelStyle:
                kGoogleStyleTexts.copyWith(color: Colors.white, fontSize: 15.0),
            unselectedIconTheme: const IconThemeData(
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
                icon: Icon(Icons.local_atm_rounded),
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
        ),
      ),
    );
  }
}

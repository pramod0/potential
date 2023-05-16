import 'package:flutter/material.dart';
import 'package:potential/models/cancreation.dart';
import 'package:potential/models/investor.dart';
import 'package:potential/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:potential/utils/AllData.dart';

import 'homeScreen.dart';
import 'investScreen.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;
  final prefs = SharedPreferences.getInstance();
  TabNavigationItem(
      {required this.page, required this.title, required this.icon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomeScreen(),
          icon: const Icon(
            Icons.home,
          ),
          title: Text(
            "Organization",
          ),
        ),
        TabNavigationItem(
          page: Dashboard(),
          icon: Icon(Icons.search),
          title: Text(
            "Branch",
          ),
        ),
        TabNavigationItem(
          page: InvestScreen(),
          icon: Icon(Icons.home),
          title: Text("Courses"),
        ),
        TabNavigationItem(
          page: Dashboard(),
          icon: Icon(Icons.home),
          title: Text("Standards"),
        ),
      ];
}

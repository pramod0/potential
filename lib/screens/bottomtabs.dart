import 'package:flutter/material.dart';
//import 'package:potential/models/cancreation.dart';
//import 'package:potential/models/investor.dart';
import 'package:potential/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:potential/utils/AllData.dart';

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
          page: const HomeScreen(),
          icon: const Icon(
            Icons.home,
          ),
          title: const Text(
            "Organization",
          ),
        ),
        TabNavigationItem(
          page: const Dashboard(),
          icon: const Icon(Icons.search),
          title: const Text(
            "Branch",
          ),
        ),
        TabNavigationItem(
          page: const InvestScreen(),
          icon: const Icon(Icons.home),
          title: const Text("Courses"),
        ),
        TabNavigationItem(
          page: const Dashboard(),
          icon: const Icon(Icons.home),
          title: const Text("Standards"),
        ),
      ];
}

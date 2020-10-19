import 'package:epicture/models/page.dart';
import 'package:epicture/repositories/page.dart';
import 'package:epicture/pages/home.dart';
import 'package:epicture/pages/profile.dart';
import 'package:epicture/pages/search.dart';
import 'package:flutter/material.dart';

class RootPageRepository extends PageRepository {
  final List<PageModel> _pages = [
    PageModel(
      builder: (context) => HomePage(),
      item: PageItemModel(
        iconData: Icons.home,
        label: "Home",
      ),
    ),
    PageModel(
      builder: (context) => SearchPage(),
      item: PageItemModel(
        iconData: Icons.search,
        label: "Search",
      ),
    ),
    PageModel(
      builder: (context) => ProfilePage(),
      item: PageItemModel(
        iconData: Icons.person,
        label: "Profile",
      ),
    ),
  ];

  @override
  List<PageModel> get pages => _pages;
}

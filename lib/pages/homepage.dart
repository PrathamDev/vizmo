import 'package:flutter/material.dart';
import 'package:vizmo/pages/hometabs/dashboard.dart';
import 'package:vizmo/pages/hometabs/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _tabIndex;
  late List<Widget> tabs;

  @override
  void initState() {
    _tabIndex = 0;
    tabs = const [Dashboard(), Profile()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
        showUnselectedLabels: false,
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
            activeIcon: Icon(Icons.dashboard_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

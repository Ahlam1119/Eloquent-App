import 'package:eloquentapp/center/homeCenter.dart';
import 'package:eloquentapp/center/manageTherapist.dart';
import 'package:eloquentapp/center/profileCenter.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});
  static String id = 'MyBottomNavigationBar_screen';

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  PageController _pageController = PageController();
  int selectedIndex = 0;
  final List<Widget> _screens = [
    const CenterHomeScreen(),
    const MTherapist(),
    const CenterProfile(),
  ];
  void _onPageChanged(int Index) {
    setState(() {
      selectedIndex = Index;
    });
  }

  void _onItemTapped(int i) {
    _pageController.jumpToPage(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25))),
          child: BottomNavigationBar(
            selectedItemColor: const Color(0xff385a4a),
            unselectedItemColor: const Color(0xff9bb0a5),
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: '',
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: selectedIndex,
          ),
        ),
      ),
    );
  }
}

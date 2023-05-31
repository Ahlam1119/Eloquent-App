import 'package:eloquentapp/therapist/Pages/Children/childreinList.dart';
import 'package:eloquentapp/therapist/Pages/Therapist_Profile.dart';
import 'package:eloquentapp/therapist/Pages/home.dart';
import 'package:eloquentapp/therapist/sessionManage.dart';
import 'package:flutter/material.dart';

class navBarForTherapist extends StatefulWidget {
  navBarForTherapist();

  @override
  _navBarForTherapistState createState() => _navBarForTherapistState();
}

class _navBarForTherapistState extends State<navBarForTherapist> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;
  List<Widget> _screens = [
    TherapistHomeScreen(),
    ChildrenList(),
    therapistsessionManage(),
    TherapistProfile(),
  ];
  void _onPageChanged(int Index) {
    setState(() {
      _selectedIndex = Index;
    });
  }

  void _onItemTapped(int i) {
    _pageController.jumpToPage(i);
  }

  Color _selectedIconColor = Color(0xff385a4a);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: _selectedIconColor,
          unselectedItemColor: Color(0xff9bb0a5),
          elevation: 2,
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                child: Image.asset(
                  "images/bxs_home.png",
                  width: 25,
                ),
                colorFilter: _selectedIndex == 0
                    ? ColorFilter.mode(_selectedIconColor, BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xff9bb0a5), BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                child: Image.asset(
                  "images/childern.png",
                  width: 25,
                ),
                colorFilter: _selectedIndex == 1
                    ? ColorFilter.mode(_selectedIconColor, BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xff9bb0a5), BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                child: Image.asset(
                  "images/ManageSession.png",
                  width: 25,
                ),
                colorFilter: _selectedIndex == 2
                    ? ColorFilter.mode(_selectedIconColor, BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xff9bb0a5), BlendMode.srcIn),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                child: Image.asset(
                  "images/profile.png",
                  width: 25,
                ),
                colorFilter: _selectedIndex == 3
                    ? ColorFilter.mode(_selectedIconColor, BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xff9bb0a5), BlendMode.srcIn),
              ),
              label: '',
            ),
          ],
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}

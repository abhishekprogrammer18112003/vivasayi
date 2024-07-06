import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/cart/cart_screen.dart';
import 'package:vivasayi/features/home/home_screen.dart';
import 'package:vivasayi/features/profile/profile_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _pages[_selectedIndex],
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 83.h,
        decoration: BoxDecoration(
          border: Border.all(
            width: 5.0,
            color: const Color.fromARGB(255, 247, 247, 247),
          ),
          borderRadius: BorderRadius.circular(10.0), // Uniform radius
        ),
        child: Material(
          elevation: 0.0,
          child: BottomNavigationBar(
            iconSize: 26.h,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            selectedItemColor: const Color.fromARGB(255, 56, 186, 0),
            unselectedItemColor: const Color.fromARGB(255, 136, 136, 136),
          ),
        ),
      ),
    );
  }
}

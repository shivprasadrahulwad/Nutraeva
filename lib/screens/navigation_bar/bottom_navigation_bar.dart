import 'package:fitness/screens/analytics/analytics_screen.dart';
import 'package:fitness/screens/home/home_screen.dart';
import 'package:fitness/screens/image_camera/camera_screen.dart';
import 'package:fitness/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class CurvedBottomNavBar extends StatefulWidget {
  const CurvedBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CurvedBottomNavBar> createState() => _CurvedBottomNavBarState();
}

class _CurvedBottomNavBarState extends State<CurvedBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AnalyticsScreen(),
    SizedBox(),
    Center(child: Text('My Diet Screen')),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    if (index == 2) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      floatingActionButton: SizedBox(
        width: 50,
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraScreen()),
            );
          },
          backgroundColor: const Color(0xFF4560DB),
          elevation: 2,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.qr_code_scanner,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 8.0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                icon: Icons.home_outlined,
                label: 'Home',
                isSelected: _selectedIndex == 0,
                onTap: () => _onItemTapped(0),
              ),
              NavBarItem(
                icon: Icons.bar_chart_outlined,
                label: 'Analytics',
                isSelected: _selectedIndex == 1,
                onTap: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40),
              NavBarItem(
                icon: Icons.restaurant_menu_outlined,
                label: 'My Diet',
                isSelected: _selectedIndex == 3,
                onTap: () => _onItemTapped(3),
              ),
              NavBarItem(
                icon: Icons.person_outline,
                label: 'Account',
                isSelected: _selectedIndex == 4,
                onTap: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF4560DB) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF4560DB) : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

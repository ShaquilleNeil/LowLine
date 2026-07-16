import 'package:flutter/material.dart';
import 'package:lowline/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:lowline/features/inventory/presentation/screens/inventory_list_screen.dart';
import 'package:lowline/features/scanner/presentation/screens/scanner_screen.dart';
import 'package:lowline/features/settings/presentation/screens/settings_screen.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedindex = 0;

static const List<Widget> screens = [
    DashboardScreen(),
    InventoryListScreen(),
    ScannerScreen(),
    SettingsScreen(),
  ];

  void onTap(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedindex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedindex,
        onTap: onTap,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          
          ),
        ],
      )
    );
  }
}
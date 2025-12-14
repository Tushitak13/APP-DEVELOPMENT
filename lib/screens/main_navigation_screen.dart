// File: screens/main_navigation_screen.dart

import 'package:flutter/material.dart';

// 🚨 CRITICAL: Ensure these three import paths are correct in your project!
// If your screens folder is directly under lib/, these paths are correct:
import 'home_screen.dart';        
import 'dashboard_screen.dart';   
import 'add_subject_screen.dart'; 


class MainNavigationScreen extends StatefulWidget {
  // We still need studentName to eventually pass to HomeScreen
  final String studentName; 
  
  const MainNavigationScreen({super.key, required this.studentName});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0; 
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // Initialize the list of screens, including the test container
    _widgetOptions = <Widget>[
      // 1. HOME SCREEN SLOT (The Pink Test Container)
      const Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: ColoredBox(
            color: Colors.pink, 
            child: Center(child: Text("HOME IS HERE", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
          ),
        ),
      ),
      
      // 2. DASHBOARD SCREEN (Must be correctly imported and have a const/default constructor)
      // Assuming DashboardScreen has a default constructor (DashboardScreen())
      DashboardScreen(), 
      
      // 3. ADD SUBJECT SCREEN (Must be correctly imported and have a const constructor)
      // Assuming AddSubjectScreen has a const constructor (const AddSubjectScreen())
      const AddSubjectScreen(), 
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.class_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Add Subject',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
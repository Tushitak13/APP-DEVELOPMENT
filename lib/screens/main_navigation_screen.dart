

import 'package:flutter/material.dart';


import 'home_screen.dart';        
import 'dashboard_screen.dart';   
import 'add_subject_screen.dart'; 


class MainNavigationScreen extends StatefulWidget {
  
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
    
    _widgetOptions = <Widget>[
      
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

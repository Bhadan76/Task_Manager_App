import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager_app/ui/screens/completed_task_screen.dart';
import 'package:task_manager_app/ui/screens/new_task_screen.dart';
import 'package:task_manager_app/ui/screens/progress_task_screen.dart';

import 'package:task_manager_app/ui/widgets/app_bar_widget.dart';
class MainNavbarHolderScreen extends StatefulWidget {
  const MainNavbarHolderScreen({super.key});
  static const String name = '/dashboard';

  @override
  State<MainNavbarHolderScreen> createState() => _MainNavbarHolderScreenState();
}

class _MainNavbarHolderScreenState extends State<MainNavbarHolderScreen> {
  int _selectedIndex=0;
  final List<Widget> _screens=[
    NewTaskScreen(),
    ProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar_widget(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected: (int index){
          _selectedIndex= index;
          setState(() {});
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.new_label_outlined), label: 'New'),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          ]
      ),
    );
  }
}





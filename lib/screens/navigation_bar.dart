import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TodoBottomNavBar extends StatefulWidget {
  const TodoBottomNavBar({super.key});

  @override
  State<TodoBottomNavBar> createState() => _TodoBottomNavBarState();
}

class _TodoBottomNavBarState extends State<TodoBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: const [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.home,
            ),
            SizedBox(height: 8), // Increase space between icon and text
            Text(
              'Tasks',
              style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500), // Adjust text style
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_month,
            ),
            SizedBox(height: 8), // Increase space between icon and text
            Text(
              'Calendar',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500), // Adjust text style
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person,
            ),
            SizedBox(height: 8), // Increase space between icon and text
            Text(
              'Profile',
              style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500), // Adjust text style
            ),
          ],
        ),
      ],
      height: 60,
      color: Colors.blue[500]!, // Base color
      buttonBackgroundColor: Colors.white70, // Background color of the buttons
      backgroundColor: Colors.white, // Background color of the navigation bar
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) {
        // Handle navigation
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../../../widgets/header_widget.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/tab_options_widget.dart';
import '../../../widgets/status_buttons_widget.dart';
import 'received_screen.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({Key? key}) : super(key: key);

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  int _selectedIndex = 3; // Default to Material tab
  int _selectedTabIndex = 0; // Default to first tab (Received)

  final List<String> _tabNames = ['Received', 'Issue', 'Reconciliation'];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(
              title: 'Project Alpha',
              leftIconPath: 'assets/svgs/building_icon.svg',
              rightIcon: Icon(Icons.menu, color: Colors.black, size: 18),
            ),
            const SizedBox(height: 16),
            TabOptionsWidget(
              tabNames: _tabNames,
              selectedIndex: _selectedTabIndex,
              onTabSelected: _onTabSelected,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: StatusButtonsWidget(),
            ),
            // Content area that changes based on selected tab
            Expanded(
              child: _getScreenForIndex(_selectedTabIndex),
            ),
            BottomNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onNavItemTapped,
              height: 79,
              items: [
                BottomNavItem(
                  label: 'Assign',
                  iconPath: 'assets/svgs/assign_icon.svg',
                  iconSize: 18,
                ),
                BottomNavItem(
                    label: 'Progress',
                    iconPath: 'assets/svgs/progress_icon.svg',
                    iconSize: 25,
                    iconTextGap: 0.2),
                BottomNavItem(
                  label: 'Dashboard',
                  iconPath: 'assets/svgs/dashboard_icon.svg',
                  iconSize: 18,
                ),
                BottomNavItem(
                  label: 'Material',
                  iconPath: 'assets/svgs/material_icon.svg',
                  iconSize: 19,
                ),
                BottomNavItem(
                  label: 'Account',
                  iconPath: 'assets/svgs/account_icon.svg',
                  iconSize: 19,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return const ReceivedScreen();
      case 1:
        // Placeholder for Issue tab content
        return const Center(child: Text('Issue tab content'));
      case 2:
        // Placeholder for Reconciliation tab content
        return const Center(child: Text('Reconciliation tab content'));
      default:
        return const ReceivedScreen();
    }
  }
}

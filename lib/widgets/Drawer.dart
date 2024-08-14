import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';

class MyDrawer extends StatelessWidget {
  final HomePageViewModel _mainModel;

  const MyDrawer({
    Key? key,
    required HomePageViewModel mainModel,
  }) : _mainModel = mainModel, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          const SizedBox(height: 24),
          _buildListItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: _mainModel.navigateToSettings,
          ),
          const SizedBox(height: 24),
          _buildListItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              _mainModel.signOut(context);
            },
          ),
           const SizedBox(height: 24),
          _buildListItem(
            icon: Icons.checklist,
            title: 'Manage My Habits',
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }

  DrawerHeader _buildDrawerHeader() {
    return const DrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xFF4d57c8),
      ),
      child: Text(
        StringConstants.appName,
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF4d57c8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
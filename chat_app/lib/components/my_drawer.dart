import 'package:chat_app/components/my_drawer_tile.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final auth = FirebaseAuth.instance;

    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerTheme:
                      const DividerThemeData(color: Colors.transparent),
                ),
                child: DrawerHeader(
                  child: Icon(
                    Icons.message,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // home
              MyDrawerTile(
                title: 'HOME',
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () => Navigator.pop(context),
              ),

              // settings
              MyDrawerTile(
                title: 'Settings',
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: MyDrawerTile(
              title: 'Logout',
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ), // logout
        ],
      ),
    );
  }
}

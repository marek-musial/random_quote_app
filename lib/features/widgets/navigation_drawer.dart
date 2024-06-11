import 'package:flutter/material.dart';
import 'package:random_quote_app/core/screen_sizes.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
          return Drawer(
            width: screenWidth / 5,
            child: NavigationRail(
              labelType: NavigationRailLabelType.all,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: Navigator.of(context).pop,
              ),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: const Icon(Icons.home),
                  label: const Text('Home'),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.info),
                  label: const Text('About'),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: const Text('Settings'),
                ),
              ],
            ),
          );
  }
}

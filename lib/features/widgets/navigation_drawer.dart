import 'package:flutter/material.dart';
import 'package:random_quote_app/core/screen_sizes.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({
    super.key,
    required this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: screenWidth / 5,
      child: NavigationRail(
        onDestinationSelected: (int index) {
          if (Navigator.canPop(context)) {
            Navigator.pushReplacementNamed(
              context,
              switch (index) {
                0 => '/',
                1 => '/about',
                int() => '/',
              },
            );
          }
        },
        selectedIndex: index ?? 0,
        labelType: NavigationRailLabelType.all,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: Navigator.of(context).pop,
        ),
        destinations: <NavigationRailDestination>[
          NavigationRailDestination(
            icon: const Icon(Icons.home),
            label: const Text('Home'),
            disabled: index == 0,
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.info),
            label: const Text('About'),
            disabled: index == 1,
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.settings),
            label: const Text('Settings'),
            disabled: index == 2,
          ),
        ],
      ),
    );
  }
}

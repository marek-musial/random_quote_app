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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.inversePrimary,
            Theme.of(context).colorScheme.primary,
          ],
          stops: const [.75, 1],
        ),
      ),
      child: Drawer(
        backgroundColor: Colors.transparent,
        width: screenWidth / 5,
        shape: Border.all(style: BorderStyle.none),
        child: NavigationRail(
          backgroundColor: Colors.transparent,
          onDestinationSelected: (int index) {
            Navigator.pushReplacementNamed(
              context,
              switch (index) {
                0 => '/',
                1 => '/about',
                int() => '/',
              },
            );
          },
          selectedIndex: index ?? 0,
          labelType: NavigationRailLabelType.all,
          leading: MediaQuery.of(context).orientation == Orientation.portrait
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: Navigator.canPop(context) ? Navigator.of(context).pop : null,
                )
              : SizedBox.square(
                  dimension: screenWidth / 12,
                  child: const Icon(Icons.menu),
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
      ),
    );
  }
}

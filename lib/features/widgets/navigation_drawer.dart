import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({
    super.key,
    required this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onPrimaryContainer;
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
        child:
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return NavigationRail(
              backgroundColor: Colors.transparent,
              onDestinationSelected: (int index) {
                globalLogger.log('Page changed to: $index');
                if (index == 0) {
                  context.read<HomeCubit>().emitPreviousState();
                }
                Navigator.pushReplacementNamed(
                  context,
                  switch (index) {
                    0 => '/',
                    1 => '/about',
                    2 => '/sources',
                    3 => '/settings',
                    int() => '/',
                  },
                );
              },
              selectedIndex: index ?? 0,
              labelType: NavigationRailLabelType.all,
              leading: MediaQuery.of(context).orientation == Orientation.portrait
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: textColor,
                      ),
                      onPressed: Navigator.canPop(context) ? Navigator.of(context).pop : null,
                    )
                  : SizedBox.square(
                      dimension: screenWidth / 12,
                      child: Icon(
                        Icons.menu,
                        color: textColor,
                      ),
                    ),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(
                    Icons.home,
                    color: textColor,
                  ),
                  label: Text(
                    'Home',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  disabled: index == 0,
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.info,
                    color: textColor,
                  ),
                  label: Text(
                    'About',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  disabled: index == 1,
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.source,
                    color: textColor,
                  ),
                  label: Text(
                    'Sources',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  disabled: index == 2,
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.settings,
                    color: textColor,
                  ),
                  label: Text(
                    'Settings',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  disabled: index == 3,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

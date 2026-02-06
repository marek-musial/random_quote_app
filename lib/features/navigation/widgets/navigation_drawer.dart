import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/features/home/cubit/home_cubit.dart';
import 'package:random_quote_app/features/navigation/cubit/navigation_drawer_cubit.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({
    super.key,
    required this.index,
  });
  final int? index;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    return SafeArea(
      top: false,
      bottom: false,
      left: true,
      right: true,
      child: Container(
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
          width: math.max(screenWidth ~/ 6, 56).toDouble(),
          shape: Border.all(style: BorderStyle.none),
          child: BlocBuilder<NavigationDrawerCubit, NavigationDrawerState>(
            builder: (context, navigationState) {
              return BlocBuilder<HomeCubit, HomeState>(
                builder: (context, homeState) {
                  return SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: (screenWidth ~/ 6).clamp(70, 120).toDouble(),
                        ),
                        child: IntrinsicHeight(
                          child: NavigationRail(
                            backgroundColor: Colors.transparent,
                            onDestinationSelected: (int index) {
                              context
                                  .read<NavigationDrawerCubit>() //R
                                  .changeNavigationIndex(index);
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
                            selectedIndex: navigationState.navigationIndex,
                            indicatorColor: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: .5),
                            labelType: NavigationRailLabelType.all,
                            leading: MediaQuery.of(context).orientation == Orientation.portrait
                                ? IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: textColor,
                                    ),
                                    onPressed: Navigator.canPop(context) //R
                                        ? Navigator.of(context).pop
                                        : null,
                                  )
                                : SizedBox.square(
                                    dimension: screenWidth / 12,
                                    child: Icon(
                                      Icons.menu,
                                      color: textColor,
                                    ),
                                  ),
                            destinations: <NavigationRailDestination>[
                              _railItem(Icons.home, 'Home', index == 0, textColor),
                              _railItem(Icons.info, 'About', index == 1, textColor),
                              _railItem(Icons.source, 'Sources', index == 2, textColor),
                              _railItem(Icons.settings, 'Settings', index == 3, textColor),
                            ],
                            trailing: Column(
                              children: [
                                Divider(
                                  color: textColor,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<NavigationDrawerCubit>() //R
                                        .turnOnFeedbackMode(context);
                                  },
                                  icon: Icon(
                                    Icons.bug_report,
                                    color: textColor,
                                  ),
                                ),
                                Text(
                                  'Leave feedback\n(Gmail)',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                ),
                                SizedBox(
                                  height: screenHeight / 64,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  NavigationRailDestination _railItem(IconData iconData, String label, bool disabled, Color textColor) {
    return NavigationRailDestination(
      icon: Icon(
        iconData,
        color: textColor,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
        ),
      ),
      disabled: disabled,
    );
  }
}

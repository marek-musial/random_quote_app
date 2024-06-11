import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/features/root/cubit/root_cubit.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return Drawer(
            width: screenWidth / 5,
            child: NavigationRail(
              onDestinationSelected: (int index) {
                context.read<RootCubit>().setDestination(index);
              },
              selectedIndex: state.destinationIndex ?? 0,
              labelType: NavigationRailLabelType.all,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: Navigator.of(context).pop,
              ),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: const Icon(Icons.home),
                  label: const Text('Home'),
                  disabled: state.destinationIndex == 0,
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.info),
                  label: const Text('About'),
                  disabled: state.destinationIndex == 1,
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: const Text('Settings'),
                  disabled: state.destinationIndex == 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/features/root/cubit/root_cubit.dart';
import 'package:random_quote_app/features/widgets/navigation_drawer.dart';
import 'package:random_quote_app/core/theme/list_tile_style.dart' as tile;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final Color tileColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(.5);
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MediaQuery.of(context).orientation == Orientation.portrait
            ? AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(title),
              )
            : null,
        drawer: const AppBarDrawer(index: 2),
        body: Row(
          children: [
            MediaQuery.of(context).orientation == Orientation.landscape ? const AppBarDrawer(index: 2) : const SizedBox.shrink(),
            Flexible(
              flex: 1,
              child: BlocBuilder<RootCubit, RootState>(
                builder: (context, state) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.all(
                          Radius.circular(screenWidth / 24),
                        ),
                        onTap: BlocProvider.of<RootCubit>(context).toggleThemeBrightness,
                        child: ListTile(
                          textColor: textColor,
                          tileColor: tileColor,
                          shape: tile.border,
                          contentPadding: tile.padding,
                          title: const Text(
                            'Theme',
                            textAlign: TextAlign.start,
                          ),
                          subtitle: Text(
                            state.isThemeBright ? 'Bright' : 'Dark',
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

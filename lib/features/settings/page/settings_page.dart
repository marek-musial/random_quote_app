import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/core/injection_container.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/core/theme/widgets/background_icon_widget.dart';
import 'package:random_quote_app/features/navigation/cubit/navigation_drawer_cubit.dart';
import 'package:random_quote_app/features/root/cubit/root_cubit.dart';
import 'package:random_quote_app/features/navigation/widgets/navigation_drawer.dart';
import 'package:random_quote_app/core/theme/list_tile_style.dart' as tile;

final BorderRadius _borderRadius = BorderRadius.circular(screenWidth / 10);

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final Color tileColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(.5);
    final double fontSize = (screenWidth / 45).clamp(14, 18);

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
      child: Stack(
        children: [
          const BackgroundIcon(),
          PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              context.read<NavigationDrawerCubit>().changeNavigationIndex(0);
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: MediaQuery.of(context).orientation == Orientation.portrait
                  ? AppBar(
                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                      title: Text(
                        title,
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      iconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    )
                  : null,
              drawer: const AppBarDrawer(index: 3),
              body: Row(
                children: [
                  MediaQuery.of(context).orientation == Orientation.landscape //R
                      ? const AppBarDrawer(index: 3)
                      : const SizedBox.shrink(),
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
                                title: Text(
                                  'Theme',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: fontSize * 1.1,
                                  ),
                                ),
                                subtitle: Text(
                                  state.isThemeBright //R
                                      ? 'Bright'
                                      : 'Dark',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight / 96,
                            ),
                            Container(
                              padding: tile.padding.copyWith(
                                top: screenHeight / 128 + screenHeight / 52,
                                bottom: screenHeight / 32,
                              ),
                              decoration: BoxDecoration(
                                color: tileColor,
                                borderRadius: tile.border.borderRadius,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Theme color',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: fontSize * 1.1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 96,
                                  ),
                                  GridView.count(
                                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait //R
                                        ? ((screenWidth * .8) / 80).round().clamp(4, 12) & ~1
                                        : ((screenHeight * .8) / 80).round().clamp(4, 12) & ~1,
                                    mainAxisSpacing: screenHeight / 96,
                                    crossAxisSpacing: screenHeight / 96,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            BlocProvider.of<RootCubit>(context).setThemeColor(null);
                                          },
                                          borderRadius: _borderRadius,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white.withOpacity(.3),
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Icon(
                                                Icons.colorize,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const ColorButton(
                                        color: Colors.amber,
                                      ),
                                      const ColorButton(
                                        color: Colors.red,
                                      ),
                                      const ColorButton(
                                        color: Colors.blue,
                                      ),
                                      const ColorButton(
                                        color: Colors.green,
                                      ),
                                      const ColorButton(
                                        color: Colors.deepPurple,
                                      ),
                                      const ColorButton(
                                        color: Colors.deepOrange,
                                      ),
                                      const ColorButton(
                                        color: Colors.indigo,
                                      ),
                                      const ColorButton(
                                        color: Colors.lime,
                                      ),
                                      const ColorButton(
                                        color: Colors.yellow,
                                      ),
                                      const ColorButton(
                                        color: Colors.teal,
                                      ),
                                      const ColorButton(
                                        color: Colors.pink,
                                      ),
                                    ],
                                  )
                                ],
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
          ),
        ],
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({super.key, required this.color});
  final Color color;

  @override
  Widget build(
    BuildContext context,
  ) {
    return BlocProvider(
      create: (context) {
        return getIt<RootCubit>();
      },
      child: Material(
        color: color,
        borderRadius: _borderRadius,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: () {
            BlocProvider.of<RootCubit>(context).setThemeColor(color);
          },
        ),
      ),
    );
  }
}

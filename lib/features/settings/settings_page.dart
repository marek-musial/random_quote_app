import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_app/features/root/cubit/root_cubit.dart';
import 'package:random_quote_app/features/widgets/navigation_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.title});
  final String title;

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
                        onTap: BlocProvider.of<RootCubit>(context).toggleThemeBrightness,
                        child: ListTile(
                          title: Text(
                            'Theme',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: textColor),
                          ),
                          subtitle: Text(
                            state.isThemeBright ? 'Bright' : 'Dark',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: textColor),
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

import 'package:flutter/material.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/core/theme/list_tile_style.dart' as tile;
import 'package:random_quote_app/core/theme/widgets/background_icon_widget.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';
import 'package:random_quote_app/features/widgets/navigation_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

final List<DataSource> dataSources = [...imageDataSources, ...quoteDataSources];

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key, required this.title});
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
      child: Stack(
        children: [
          const BackgroundIcon(),
          Scaffold(
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
            drawer: const AppBarDrawer(index: 2),
            body: Row(
              children: [
                MediaQuery.of(context).orientation == Orientation.landscape ? const AppBarDrawer(index: 2) : const SizedBox.shrink(),
                Flexible(
                  flex: 1,
                  child: ListView.separated(
                    itemCount: dataSources.length + 2,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return ListTile(
                          textColor: textColor,
                          tileColor: tileColor,
                          shape: tile.border,
                          contentPadding: tile.padding,
                          title: const Text(
                            'Image sources:',
                            textAlign: TextAlign.center,
                          ),
                          subtitle: const Text(
                            'All images are a subject of their respective apis licenses.',
                          ),
                        );
                      }
                      if (index == imageDataSources.length + 1) {
                        return ListTile(
                          textColor: textColor,
                          tileColor: tileColor,
                          shape: tile.border,
                          contentPadding: tile.padding,
                          title: const Text(
                            'Quote sources:',
                            textAlign: TextAlign.center,
                          ),
                          subtitle: const Text(
                            'All quotes are a subject of their recpective apis licenses.',
                          ),
                        );
                      }
                      if (index > imageDataSources.length) {
                        return SourceListTile(dataSource: dataSources[index - 2]);
                      }
                      return SourceListTile(dataSource: dataSources[index - 1]);
                    },
                    separatorBuilder: (BuildContext context, int index) => SizedBox(
                      height: screenHeight / 96,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SourceListTile extends StatelessWidget {
  const SourceListTile({
    super.key,
    this.dataSource,
  });

  final DataSource? dataSource;

  Future<void> _launchUrl() async {
    if (dataSource?.link != null) {
      final Uri uri = Uri.parse(dataSource!.link!);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      )) {
        throw Exception('Could not launch ${dataSource?.link}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final Color containerColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(.5);
    return Tooltip(
      message: dataSource?.link,
      triggerMode: TooltipTriggerMode.longPress,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(screenWidth / 24),
        ),
        child: ListTile(
          textColor: textColor,
          tileColor: containerColor,
          shape: tile.border,
          contentPadding: tile.padding,
          title: Text(
            dataSource?.title ?? '',
            textAlign: TextAlign.start,
          ),
          subtitle: Text(
            dataSource?.blurb ?? '',
            textAlign: TextAlign.start,
          ),
        ),
        onTap: () {
          _launchUrl();
        },
      ),
    );
  }
}

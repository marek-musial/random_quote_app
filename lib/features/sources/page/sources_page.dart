import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_quote_app/core/injection_container.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/core/theme/list_tile_style.dart' as tile;
import 'package:random_quote_app/core/theme/widgets/background_icon_widget.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/features/navigation/widgets/navigation_drawer.dart';
import 'package:random_quote_app/features/sources/providers/data_source_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

final _imageDataSources = getIt<List<ImageDataSource>>();
final _quoteDataSources = getIt<List<QuoteDataSource>>();
final _dataSources = getIt<List<DataSource>>();

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key, required this.title});
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
                MediaQuery.of(context).orientation == Orientation.landscape //R
                    ? const AppBarDrawer(index: 2)
                    : const SizedBox.shrink(),
                Flexible(
                  flex: 1,
                  child: ChangeNotifierProvider(
                    create: (_) => DataSourceNotifier(),
                    child: ListView.separated(
                      itemCount: _dataSources.length + 3,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return ListTile(
                            textColor: textColor,
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
                        if (index == _imageDataSources.length + 1) {
                          return ListTile(
                            textColor: textColor,
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
                        if (index == _imageDataSources.length + _quoteDataSources.length + 2) {
                          return ListTile(
                            textColor: Theme.of(context).colorScheme.onPrimaryFixedVariant,
                            contentPadding: tile.padding,
                            title: const Text(
                              'At least one of each type of sources must be enabled at a time!',
                              textAlign: TextAlign.center,
                            ),
                            subtitle: const Text(
                              'Occasionally, some APIs may return invalid responses or be unavailable.\nHaving more sources active helps prevent API connection errors.',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        if (index > _imageDataSources.length) {
                          return SourceListTile(
                            dataSource: _dataSources[index - 2],
                          );
                        }
                        return SourceListTile(
                          dataSource: _dataSources[index - 1],
                        );
                      },
                      separatorBuilder: (
                        BuildContext context,
                        int index,
                      ) =>
                          SizedBox(
                        height: screenHeight / 96,
                      ),
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
    required this.dataSource,
  });

  final DataSource dataSource;

  Future<void> _launchUrl() async {
    if (dataSource.link != null) {
      final Uri uri = Uri.parse(dataSource.link!);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      )) {
        throw Exception('Could not launch ${dataSource.link}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final Color containerColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(.5);

    return ExpansionTile(
      textColor: textColor,
      collapsedTextColor: textColor,
      backgroundColor: containerColor,
      collapsedBackgroundColor: containerColor,
      shape: tile.border,
      collapsedShape: tile.border,
      tilePadding: tile.padding,
      title: Text(
        dataSource.title,
        textAlign: TextAlign.start,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      trailing: Consumer<DataSourceNotifier>(
        builder: (context, dataSourceNotifier, child) {
          return Switch.adaptive(
              value: dataSource.isEnabled,
              onChanged: (_) {
                dataSourceNotifier.toggleDataSource(dataSource.title);
              });
        },
      ),
      childrenPadding: tile.padding,
      children: [
        Text(
          dataSource.blurb ?? '',
          textAlign: TextAlign.start,
          style: TextStyle(
            color: textColor,
          ),
        ),
        TextButton(
          onPressed: _launchUrl,
          child: Text('Go to source'),
        )
      ],
    );
  }
}

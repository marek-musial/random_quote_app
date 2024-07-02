import 'package:flutter/material.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/data/remote_data_sources/data_source.dart';
import 'package:random_quote_app/domain/repositories/image_repository.dart';
import 'package:random_quote_app/domain/repositories/quote_repository.dart';
import 'package:random_quote_app/features/widgets/navigation_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

final List<DataSource> dataSources = [...imageDataSources, ...quoteDataSources];

class AboutPage extends StatelessWidget {
  const AboutPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(title),
            )
          : null,
      drawer: const AppBarDrawer(index: 1),
      body: ListView.separated(
        itemCount: dataSources.length + 3,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return const ListTile(
              title: Text(
                'What is this app about?',
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'This app utilizes various apis of random quotes and images, to produce a vast choice of randomized inspirational or entertertaining images with one press of a button.',
                textAlign: TextAlign.center,
              ),
            );
          }
          if (index == 1) {
            return const ListTile(
              title: Text(
                'Image sources:',
                textAlign: TextAlign.center,
              ),
              subtitle: Text('All images are a subject of their respective apis licenses.'),
            );
          }
          if (index == imageDataSources.length + 2) {
            return const ListTile(
              title: Text(
                'Quote sources:',
                textAlign: TextAlign.center,
              ),
              subtitle: Text('All quotes are a subject of their recpective apis licenses.'),
            );
          }
          index -= 1;
          if (index >= imageDataSources.length + 1) {
            return SourceListTile(dataSource: dataSources[index - 2]);
          }
          index -= 1;
          return SourceListTile(dataSource: dataSources[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const AboutListDivider(),
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
    return Tooltip(
      message: dataSource?.link,
      triggerMode: TooltipTriggerMode.longPress,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(screenWidth / 32),
        ),
        child: ListTile(
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

class AboutListDivider extends StatelessWidget {
  const AboutListDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 20,
      endIndent: 20,
    );
  }
}

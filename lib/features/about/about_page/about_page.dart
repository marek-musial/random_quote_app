import 'package:flutter/material.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/data/remote_data_sources/image_remote_data_source.dart';
import 'package:random_quote_app/data/remote_data_sources/quote_remote_data_source.dart';
import 'package:random_quote_app/features/widgets/navigation_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

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
      drawer: const AppBarDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            title: Text(
              'What is this app about?',
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              'This app utilizes various apis of random quotes and images, to produce a vast choice of randomized inspirational or entertertaining images with one press of a button.',
              textAlign: TextAlign.center,
            ),
          ),
          const AboutListDivider(),
          const ListTile(
            title: Text(
              'Image sources:',
              textAlign: TextAlign.center,
            ),
            subtitle: Text('All images are a subject of their respective apis licenses.'),
          ),
          const AboutListDivider(),
          SourceListTile(
            imageDataSource: PicsumImageRemoteDataSource(),
          ),
          const AboutListDivider(),
          SourceListTile(
            imageDataSource: CataasImageRemoteDataSource(),
          ),
          const AboutListDivider(),
          SourceListTile(
            imageDataSource: PexelsImageRemoteDataSource(),
          ),
          const AboutListDivider(),
          const ListTile(
            title: Text(
              'Quote sources:',
              textAlign: TextAlign.center,
            ),
            subtitle: Text('All quotes are a subject of their recpective apis licenses.'),
          ),
          const AboutListDivider(),
          SourceListTile(
            quoteDataSource: KanyeQuoteRemoteDataSource(),
          ),
          const AboutListDivider(),
          SourceListTile(
            quoteDataSource: AffirmationsQuoteRemoteDataSource(),
          ),
          const AboutListDivider(),
          SourceListTile(
            quoteDataSource: AdviceQuoteRemoteDataSource(),
          ),
          const AboutListDivider(),
          SourceListTile(
            quoteDataSource: QuotableQuoteRemoteDataSource(),
          ),
          const AboutListDivider(),
        ],
      ),
    );
  }
}

class SourceListTile extends StatelessWidget {
  const SourceListTile({
    super.key,
    this.imageDataSource,
    this.quoteDataSource,
  });

  final ImageDataSource? imageDataSource;
  final QuoteDataSource? quoteDataSource;

  Future<void> _launchUrl() async {
    if (imageDataSource?.link != null) {
      final Uri uri = Uri.parse(imageDataSource!.link!);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      )) {
        throw Exception('Could not launch ${imageDataSource?.link}');
      }
    }
    if (quoteDataSource?.link != null) {
      final Uri uri = Uri.parse(quoteDataSource!.link!);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      )) {
        throw Exception('Could not launch ${quoteDataSource?.link}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: imageDataSource?.link ?? quoteDataSource?.link,
      triggerMode: TooltipTriggerMode.longPress,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(screenWidth / 32),
        ),
        child: ListTile(
          title: Text(
            imageDataSource?.title ?? quoteDataSource?.title ?? '',
            textAlign: TextAlign.start,
          ),
          subtitle: Text(
            imageDataSource?.blurb ?? quoteDataSource?.blurb ?? '',
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

import 'package:flutter/material.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
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
        children: const [
          ListTile(
            title: Text(
              'What is this app about?',
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              'This app utilizes various apis of random quotes and images, to produce a vast choice of randomized inspirational or entertertaining images with one press of a button.',
              textAlign: TextAlign.center,
            ),
          ),
          AboutListDivider(),
          ListTile(
            title: Text(
              'Image sources:',
              textAlign: TextAlign.center,
            ),
            subtitle: Text('All images are a subject of their respective apis licenses.'),
          ),
          AboutListDivider(),
          SourceListTile(
            title: 'Picsum',
            subtitle: 'Lorem Picsum is a service providing easy to use, stylish placeholders.\nCreated by David Marby & Nijiko Yonskai.',
            link: 'https://picsum.photos/',
          ),
          AboutListDivider(),
          SourceListTile(
            title: 'Cataas',
            subtitle: 'Cat as a service (CATAAS) is a REST API to spread peace and love (or not) thanks to cats.\nCreated by Kevin Balicot.',
            link: 'https://cataas.com/',
          ),
          AboutListDivider(),
          SourceListTile(
            title: 'Pexels',
            subtitle: 'The best free stock photos, royalty free images & videos shared by creators.',
            link: 'https://www.pexels.com/api/',
          ),
          AboutListDivider(),
          ListTile(
            title: Text(
              'Quote sources:',
              textAlign: TextAlign.center,
            ),
            subtitle: Text('All quotes are a subject of their recpective apis licenses.'),
          ),
          AboutListDivider(),
          SourceListTile(
            title: 'kanye.rest',
            subtitle: 'A free REST API for random Kanye West quotes (Kanye as a Service).\nCreated by Andrew Jazbec.',
            link: 'https://kanye.rest/',
          ),
          AboutListDivider(),
          SourceListTile(
            title: 'Affirmations',
            subtitle: 'A tiny api for fighting impostor syndrome and building example apps.\nCreated by Tilde Thurium.',
            link: 'https://www.affirmations.dev/',
          ),
          AboutListDivider(),
          SourceListTile(
            title: 'Advice Slip JSON API',
            subtitle: 'Generate random advice slips.\nCreated by Tom Kiss.',
            link: 'https://api.adviceslip.com/',
          ),
          AboutListDivider(),
          SourceListTile(
            title: 'Quotable',
            subtitle: 'Quotable is a free, open source quotations API. It was originally built as part of a FreeCodeCamp project.\nCreated by Luke Peavey.',
            link: 'https://api.quotable.io',
          ),
          AboutListDivider(),
        ],
      ),
    );
  }
}

class SourceListTile extends StatelessWidget {
  const SourceListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.link,
  });

  final String? title;
  final String? subtitle;
  final String? link;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: link,
      triggerMode: TooltipTriggerMode.longPress,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(screenWidth / 32),
        ),
        child: ListTile(
          title: Text(
            title ?? '',
            textAlign: TextAlign.start,
          ),
          subtitle: Text(
            subtitle ?? '',
            textAlign: TextAlign.start,
          ),
        ),
        onTap: () {
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

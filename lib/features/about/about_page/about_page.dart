import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:random_quote_app/core/assets/quoteput_icons.dart';
import 'package:random_quote_app/core/logger.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/core/theme/list_tile_style.dart' as tile;
import 'package:random_quote_app/core/theme/widgets/background_icon_widget.dart';
import 'package:random_quote_app/features/widgets/navigation_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final Color tileColor = Theme.of(context).colorScheme.primaryContainer.withOpacity(.5);
    final double? headlineSize = Theme.of(context).textTheme.titleLarge!.fontSize;
    final double? bodySize = Theme.of(context).textTheme.bodyLarge!.fontSize;
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
            drawer: const AppBarDrawer(index: 1),
            body: Row(
              children: [
                MediaQuery.of(context).orientation == Orientation.landscape ? const AppBarDrawer(index: 1) : const SizedBox.shrink(),
                Flexible(
                  flex: 1,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      Icon(
                        Quoteput.quoteput,
                        size: screenWidth / 5,
                        color: textColor,
                      ),
                      Text(
                        'Quoteput',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: headlineSize,
                        ),
                      ),
                      Text(
                        'Version 1.0.0',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColor),
                      ),
                      Text(
                        'Developed by: Marek Musiał',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColor),
                      ),
                      SizedBox(
                        height: screenHeight / 96 * 2,
                      ),
                      ListTile(
                        textColor: textColor,
                        tileColor: tileColor,
                        shape: tile.border,
                        contentPadding: tile.padding,
                        title: Text(
                          'What is this app about?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: headlineSize,
                          ),
                        ),
                        subtitle: Text(
                          'This app utilizes various apis of random quotes and images, to produce a vast choice of randomized inspirational or entertertaining images with one press of a button.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: bodySize),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 96,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: tileColor,
                          shape: BoxShape.rectangle,
                          borderRadius: tile.border.borderRadius,
                        ),
                        constraints: BoxConstraints(
                          maxHeight: screenHeight.toDouble(),
                          maxWidth: screenWidth.toDouble(),
                        ),
                        padding: tile.padding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Our links:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: headlineSize,
                                color: textColor,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight / 96,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.expand(
                                height: screenHeight / 10,
                                width: screenWidth * 9 / 10,
                              ),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  SocialMediaButton(
                                    textColor: textColor,
                                    bodySize: bodySize,
                                    iconData: FontAwesomeIcons.xTwitter,
                                    iconSize: screenWidth / 10,
                                    text: 'X',
                                    url: 'https://x.com/MarekMusialDev',
                                  ),
                                  SocialMediaButton(
                                    textColor: textColor,
                                    bodySize: bodySize,
                                    iconData: FontAwesomeIcons.instagram,
                                    iconSize: screenWidth / 10,
                                    text: 'Instagram',
                                    url: 'https://www.instagram.com/marek.musial.dev/',
                                  ),
                                  SocialMediaButton(
                                    textColor: textColor,
                                    bodySize: bodySize,
                                    iconData: FontAwesomeIcons.googlePlay,
                                    iconSize: screenWidth / 12,
                                    text: 'Google play',
                                    url: '',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 96,
                      ),
                      InkWell(
                        onTap: () {
                          //implement rating
                        },
                        customBorder: tile.border,
                        child: ListTile(
                          textColor: textColor.withOpacity(.5),
                          tileColor: tileColor.withOpacity(.2),
                          shape: tile.border,
                          contentPadding: tile.padding / 4,
                          title: Text(
                            'Rate the app',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: headlineSize,
                            ),
                          ),
                          subtitle: Text(
                            'It really helps!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: bodySize,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    super.key,
    required this.textColor,
    required this.bodySize,
    required this.text,
    required this.iconData,
    required this.iconSize,
    required this.url,
  });

  final Color textColor;
  final double? bodySize;
  final String? text;
  final IconData iconData;
  final double? iconSize;
  final String? url;

  Future<void> _launchUrl(String link) async {
    try {
      final Uri uri = Uri.parse(link);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      )) {
        globalLogger.log('Could not launch $link');
        throw Exception('Could not launch $link');
      }
    } catch (e) {
      globalLogger.log('Could not launch $link due to: $e');
      throw Exception('Could not launch $link due to: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: screenWidth / 7),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  if (url != null && Uri.parse(url!).isAbsolute) {
                    _launchUrl(url!);
                  } else {
                    null;
                  }
                },
                icon: Icon(
                  iconData,
                  color: url != null && Uri.parse(url!).isAbsolute ? textColor : textColor.withOpacity(.5),
                ),
                padding: EdgeInsets.zero,
                iconSize: iconSize ?? screenWidth / 7,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                text ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: url != null && Uri.parse(url!).isAbsolute ? textColor : textColor.withOpacity(.5),
                  fontSize: bodySize! * 4 / 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:random_quote_app/core/screen_sizes.dart';
import 'package:random_quote_app/core/theme/list_tile_style.dart' as tile;
import 'package:random_quote_app/features/widgets/navigation_drawer.dart';

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MediaQuery.of(context).orientation == Orientation.portrait
            ? AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text(title),
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
                  Text(
                    'Quoter',
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
                          'Our social media:',
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
                                iconSize: screenWidth / 10,
                              ),
                              SocialMediaButton(
                                textColor: textColor,
                                bodySize: bodySize,
                                iconSize: screenWidth / 10,
                                url: '',
                              ),
                              SocialMediaButton(
                                textColor: textColor,
                                bodySize: bodySize,
                                iconSize: screenWidth / 12,
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
                      textColor: textColor,
                      tileColor: tileColor,
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
  final String url;

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
                  //implement social media url launched from url String
                },
                icon: Icon(
                  iconData,
                  color: textColor,
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
                  color: textColor,
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

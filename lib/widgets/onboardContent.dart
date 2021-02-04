import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OnboardContent extends StatelessWidget {
  final String text;
  final String description;
  final String element1;
  final String element2;
  final String image;

  OnboardContent({
    @required this.text,
    @required this.description,
    @required this.element1,
    @required this.element2,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                element1,
                height: size.height * 0.1,
                width: size.height * 0.1,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                element2,
                height: size.height * 0.1,
                width: size.height * 0.1,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                image,
                height: size.height * 0.6,
              ),
            ),
          ],
        ),
        /* SizedBox(
          height: 32,
        ), */
        Flexible(
          child: FractionallySizedBox(
            heightFactor: 0.32,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                text,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 2,
                maxFontSize: 36,
                minFontSize: 8,
              ),
              AutoSizeText(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxFontSize: 28,
                minFontSize: 6,
                maxLines: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

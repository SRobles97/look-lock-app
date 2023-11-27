import 'dart:ui';

import 'package:flutter/material.dart';

class PageWithImageBackground extends StatelessWidget {
  final String imageName;
  final Widget child;

  const PageWithImageBackground({
    Key? key,
    required this.imageName,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            'assets/images/$imageName.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Theme.of(context).colorScheme.background.withOpacity(0.2),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.transparent),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

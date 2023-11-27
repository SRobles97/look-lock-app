import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class LookLockLogo extends StatelessWidget {
  final String name;
  final double width;
  final bool shadow;

  const LookLockLogo({
    Key? key,
    required this.name,
    this.width = 200,
    this.shadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: shadow
          ? SimpleShadow(
              opacity: 0.4,
              color: Colors.blue,
              offset: const Offset(5, 5),
              sigma: 3,
              child: Image.asset(
                'assets/logos/$name.png',
                width: width,
              ),
            )
          : Image.asset(
              'assets/logos/$name.png',
              width: width,
            ),
    );
  }
}

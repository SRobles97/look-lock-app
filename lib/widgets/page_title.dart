import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String subtitle2;

  const PageTitle(
      {super.key,
      required this.title,
      required this.subtitle,
      this.subtitle2 = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 15),
            Text(
              title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle2,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

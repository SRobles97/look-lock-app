import 'package:flutter/material.dart';
import 'package:look_lock_app/widgets/styled_button.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final Function buttonAction;

  const AlertCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Text(
                  'Fecha',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(title, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Column(
              children: [
                Text(
                  'Hora',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            StyledButton(
              text: buttonText,
              onPressed: () => buttonAction,
              horizontalPadding: 20,
              verticalPadding: 10,
              fontSize: 12,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:look_lock_app/utils/theme_helper.dart';

class StyledButton extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const StyledButton({
    Key? key,
    this.horizontalPadding = 110,
    this.verticalPadding = 15,
    required this.text,
    required this.onPressed,
    this.color = ThemeHelper.primary,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: textColor,
              fontFamily: GoogleFonts.firaSansCondensed().fontFamily,
            ),
      ),
    );
  }
}

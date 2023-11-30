import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight;
  final double svgHeight;
  final String svgAssetPath;

  const CustomAppBar(
      {Key? key,
        required this.appBarHeight,
        required this.svgHeight,
        required this.svgAssetPath})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: Theme.of(context).iconTheme,
      centerTitle: true,
      flexibleSpace: Align(
        alignment: Alignment.center,
        child: SvgPicture.asset(
          'assets/svg/$svgAssetPath',
          height: svgHeight,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

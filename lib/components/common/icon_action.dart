import 'package:flutter/material.dart';

class IconAction extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;

  const IconAction({Key? key, required this.onTap, required this.icon, this.iconSize, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: iconSize ?? 26,
        color: iconColor ?? Theme.of(context).primaryColorDark,
      ),
    );
  }
}

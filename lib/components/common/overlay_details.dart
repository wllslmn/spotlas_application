import 'package:flutter/material.dart';
import 'package:spotlas_test/components/common/icon_action.dart';
import 'package:spotlas_test/presentation/config/screen_size_config.dart';

class OverlayDetails extends StatelessWidget {
  final SizeConfig sizeConfig;
  final String imageUrl;
  final String title;
  final String desc;
  final IconData icon;
  final Color borderColor;
  final String fallBackImage;
  final Color? iconColor;
  final double? imageSize;

  final Function() onActionTap;

  const OverlayDetails({
    Key? key,
    required this.sizeConfig,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.icon,
    required this.borderColor,
    required this.onActionTap,
    required this.fallBackImage,
    this.iconColor,
    this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: imageSize ?? 55,
          width: imageSize ?? 55,
          decoration: BoxDecoration(border: Border.all(width: 4, color: borderColor), borderRadius: BorderRadius.circular(500)),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, e, s) => Image.network(
                fallBackImage,
                fit: BoxFit.fill,
                errorBuilder: (context, e, s) => Container(
                  color: Theme.of(context).primaryColorLight,
                  child: Center(
                      child: Icon(
                    Icons.close,
                    color: Theme.of(context).backgroundColor,
                    size: 20,
                  )),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeConfig.getHorizontalSize("s")),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: sizeConfig.getVerticalSize("xxxs")),
                  child: Text(
                    desc,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconAction(onTap: onActionTap, icon: icon, iconColor: iconColor ?? Theme.of(context).backgroundColor),
      ],
    );
  }
}

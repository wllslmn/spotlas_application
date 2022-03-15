import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls;
  final bool hasOverlayDetails;
  final String fallBackImageUrl;
  final Widget? fallBackWidget;
  final Function() onDoubleTap;

  const ImageSlider({Key? key, required this.imageUrls, required this.hasOverlayDetails, required this.fallBackImageUrl, this.fallBackWidget, required this.onDoubleTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: PageView.builder(
        controller: PageController(),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return buildImageSlider(context, index);
        },
      ),
    );
  }

  Widget buildImageSlider(final BuildContext context, final int index) {
    return Container(
      foregroundDecoration: hasOverlayDetails ? const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.transparent, Colors.transparent, Colors.black87],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.2, 0.8, 1],
        ),
      ) : null,
      child: Image.network(
        imageUrls[index],
        fit: BoxFit.fill,
        errorBuilder: (context, e, s) => Image.network(
          fallBackImageUrl,
          fit: BoxFit.fill,
          errorBuilder: (context, e, s) => fallBackWidget ?? Container(
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
    );
  }
}

import 'package:flutter/material.dart';

class SizeConfig {
  late final double _screenWidth;
  late final double _screenHeight;
  //size maps to be used in UI - initialised to S
  Map<String, double> verticalSizes = {"xxxxs": 1, "xxxs": 1, "xxs": 2, "xs": 4, "s": 8, "m": 12, "l": 16, "xl": 24, "xxl": 32, "xxxl": 48, "xxxxl": 96};
  Map<String, double> horizontalSizes = {"xxxxs": 1, "xxxs": 1, "xxs": 2, "xs": 4, "s": 8, "m": 12, "l": 16, "xl": 24, "xxl": 32, "xxxl": 48, "xxxxl": 96};
  //guide size mapping
  final Map<String, double> _smallSizes = {"xxxxs": 1, "xxxs": 1, "xxs": 2, "xs": 4, "s": 8, "m": 12, "l": 16, "xl": 24, "xxl": 32, "xxxl": 48, "xxxxl": 96};
  final Map<String, double> _mediumSizes = {"xxxxs": 1, "xxxs": 2, "xxs": 4, "xs": 8, "s": 12, "m": 16, "l": 24, "xl": 32, "xxl": 48, "xxxl": 64, "xxxxl": 128};
  final Map<String, double> _largeSizes = {"xxxxs": 1, "xxxs": 3, "xxs": 6, "xs": 12, "s": 16, "m": 24, "l": 32, "xl": 40, "xxl": 56, "xxxl": 80, "xxxxl": 160};

  void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _generateSizeValues(_screenHeight, _screenWidth);
  }

  double getHorizontalSize(final String key){
    return horizontalSizes.entries.where((element) => element.key == key).first.value;
  }

  double getVerticalSize(final String key){
    return verticalSizes.entries.where((element) => element.key == key).first.value;
  }

  void _generateSizeValues(final double screenHeight, final double screenWidth) {
    //small screen size limits
    const double smallScreenHeight = 667;
    const double smallScreenWidth = 320;
    //medium screen size limits
    const double mediumScreenHeight = 812;
    const double mediumScreenWidth = 375;
    //large screen size limits
    const double largeScreenHeight = 926;
    const double largeScreenWidth = 428;
    //calculate horizontal and vertical factors
    final Map<String, double> smallToMediumHorizontalFactor = _smallSizes.map((key, value) => MapEntry(key, _getFactor(_smallSizes, _mediumSizes, key, smallScreenWidth, mediumScreenWidth)));
    final Map<String, double> smallToMediumVerticalFactor = _smallSizes.map((key, value) => MapEntry(key, _getFactor(_smallSizes, _mediumSizes, key, smallScreenHeight, mediumScreenHeight)));
    final Map<String, double> mediumToLargeHorizontalFactor = _mediumSizes.map((key, value) => MapEntry(key, _getFactor(_mediumSizes, _largeSizes, key, mediumScreenWidth, largeScreenWidth)));
    final Map<String, double> mediumToLargeVerticalFactor = _mediumSizes.map((key, value) => MapEntry(key, _getFactor(_mediumSizes, _largeSizes, key, mediumScreenHeight, largeScreenHeight)));
    //calculate horizontal and vertical sizeMap values
    horizontalSizes = _calculateHorizontalSizes(screenWidth, smallScreenWidth, mediumScreenWidth, largeScreenWidth, smallToMediumHorizontalFactor, mediumToLargeHorizontalFactor);
    verticalSizes = _calculateVerticalSizes(screenHeight, smallScreenHeight, mediumScreenHeight, largeScreenHeight, smallToMediumVerticalFactor, mediumToLargeVerticalFactor);
  }

  Map<String, double> _calculateHorizontalSizes(double screenWidth, double smallScreenWidth, double mediumScreenWidth, double largeScreenWidth, Map<String, double> smallToMediumHorizontalFactor, Map<String, double> mediumToLargeHorizontalFactor) {
    if (screenWidth <= smallScreenWidth) {
      return _smallSizes;
    } else if (screenWidth == mediumScreenWidth) {
      return _mediumSizes;
    } else if (screenWidth == largeScreenWidth) {
      return _largeSizes;
    } else if (screenWidth > smallScreenWidth && screenWidth < mediumScreenWidth) {
      return _setSizeMap(_smallSizes, screenWidth - smallScreenWidth, smallToMediumHorizontalFactor);
    } else if (screenWidth > mediumScreenWidth && screenWidth < largeScreenWidth) {
      return _setSizeMap(_mediumSizes, screenWidth - mediumScreenWidth, mediumToLargeHorizontalFactor);
    }
    return _largeSizes;
  }

  Map<String, double> _calculateVerticalSizes(double screenHeight, double smallScreenHeight, double mediumScreenHeight, double largeScreenHeight, Map<String, double> smallToMediumVerticalFactor, Map<String, double> mediumToLargeVerticalFactor) {
    if (screenHeight <= smallScreenHeight) {
      return _smallSizes;
    } else if (screenHeight == mediumScreenHeight) {
      return _mediumSizes;
    } else if (screenHeight == largeScreenHeight) {
      return _largeSizes;
    } else if (screenHeight > smallScreenHeight && screenHeight < mediumScreenHeight) {
      return _setSizeMap(_smallSizes, screenHeight - smallScreenHeight, smallToMediumVerticalFactor);
    } else if (screenHeight > mediumScreenHeight && screenHeight < largeScreenHeight) {
      return _setSizeMap(_mediumSizes, screenHeight - mediumScreenHeight, mediumToLargeVerticalFactor);
    }
    return _largeSizes;
  }

  double _getFactor(final Map<String, double> smallMap, final Map<String, double> bigMap, final String key, final double smallSize, final double bigSize) {
    return ((bigMap.entries.where((element) => element.key == key).first.value) - (smallMap.entries.where((element) => element.key == key).first.value)) / (bigSize - smallSize);
  }

  Map<String, double> _setSizeMap(final Map<String, double> sizeMap, final double difference, final Map<String, double> factorMap) {
    return sizeMap
        .map((key, value) => MapEntry(key, value + difference * factorMap.entries.where((element) => element.key == key).first.value));
  }
}

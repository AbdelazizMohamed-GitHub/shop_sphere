import 'package:flutter/material.dart';

class ResponsiveLayout {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1200) {
      return 5;
    } else if (width >= 1024) {
      return 4;
    } else if (width >= 600) {
      return 3;
    } else {
      return 2;
    }
  }

  static double getHorizontalPadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1024) {
      return 32.0;
    } else if (width >= 600) {
      return 16.0;
    } else {
      return 12.0;
    }
  }

  static double getItemWidth(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    int count = getCrossAxisCount(context);
    double spacing = 16 * (count - 1); // فرضًا spacing بين العناصر 16
    double padding = getHorizontalPadding(context) * 2;
    return (totalWidth - spacing - padding) / count;
  }

  static double getHorizontalLargePadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1024) {
      return 250.0;
    } else if (width >= 600) {
      return 100.0;
    } else {
      return 16.0;
    }
  }
}

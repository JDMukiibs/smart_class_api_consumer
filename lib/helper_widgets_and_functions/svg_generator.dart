import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

// SVG Widgets to be used in app
final String welcomeIllustration = 'assets/welcome_screen_illustration.svg';
final Widget welcomeSVG = SvgPicture.asset(
    welcomeIllustration,
    semanticsLabel: 'Welcome Screen Illustration'
);

final String metricReportsIllustration = 'assets/home_screen_row1.svg';
final Widget metricReportsSVG = SvgPicture.asset(
  metricReportsIllustration,
  semanticsLabel: 'Metric Reports Illustration',
);

final String imagesIllustration = 'assets/home_screen_row2.svg';
final Widget imagesSVG = SvgPicture.asset(
  imagesIllustration,
  semanticsLabel: 'Metric Reports Illustration',
);

final String recentReportIllustration = 'assets/home_screen_row3.svg';
final Widget recentSVG = SvgPicture.asset(
  recentReportIllustration,
  semanticsLabel: 'Metric Reports Illustration',
);
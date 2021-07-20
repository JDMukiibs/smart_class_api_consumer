import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'assets/welcome_screen_illustration.svg';
final Widget welcomeSVG = SvgPicture.asset(
    assetName,
    semanticsLabel: 'Welcome Screen Illustration'
);
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_palette.dart';

/// Icons are the exact paths from the wireframes, stored in assets/icons.
enum AppIcons {
  back,
  bell,
  chevronRight('chevron_right'),
  comment,
  community,
  healthy,
  heart,
  more,
  settings,
  share,
  signs,
  warning;

  const AppIcons([this._file]);

  final String? _file;

  String get asset => 'assets/icons/${_file ?? name}.svg';
}

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key, this.size = 24, this.color});

  final AppIcons icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.asset,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? context.palette.textPrimary,
        BlendMode.srcIn,
      ),
    );
  }
}

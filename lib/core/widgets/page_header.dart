import 'package:flutter/material.dart';

import '../theme/app_palette.dart';
import '../theme/app_text.dart';

/// Title and subtitle at the top of a Day screen, with optional actions.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions = const [],
  });

  final String title;
  final String subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Semantics(
                header: true,
                child: Text(title, style: AppText.pageTitle),
              ),
              Text(
                subtitle,
                style: AppText.bodySmall.copyWith(
                  color: context.palette.textSecondary,
                ),
              ),
            ],
          ),
        ),
        ...actions,
      ],
    );
  }
}

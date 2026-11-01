import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_card.dart';

/// A card of rows with a thin line between them.
class DividedCard extends StatelessWidget {
  const DividedCard({super.key, required this.rows});

  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, row) in rows.indexed) ...[
            if (index > 0) const Divider(height: 1, color: DayColors.divider),
            row,
          ],
        ],
      ),
    );
  }
}

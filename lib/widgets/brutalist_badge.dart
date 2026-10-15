import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/neobrutalist_theme.dart';
import 'custom_icons.dart';

class BrutalistBadge extends StatelessWidget {
  final String nameFirst;
  final String nameLast;

  const BrutalistBadge({
    super.key,
    required this.nameFirst,
    required this.nameLast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top Tilted Sticker
        Transform.rotate(
          angle: -3.5 * (math.pi / 180),
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              border: Border.all(color: AppColors.ink, width: 2.2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1F000000), // rgba(0,0,0,0.12)
                  offset: Offset(-1, 2),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Text(
              nameFirst.toUpperCase(),
              style: AppTypography.headingLarge(),
            ),
          ),
        ),

        // Bottom Overlapping Sticker with Smiley
        Transform.translate(
          offset: const Offset(20, -8),
          child: Container(
            padding:
                const EdgeInsets.only(left: 12, right: 18, top: 7, bottom: 7),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              border: Border.all(color: AppColors.ink, width: 2.2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrutalistSmileyWidget(size: 42),
                const SizedBox(width: 14),
                Text(
                  nameLast.toUpperCase(),
                  style: AppTypography.monoBadge(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

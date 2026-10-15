import 'package:flutter/material.dart';
import '../theme/neobrutalist_theme.dart';

class SectionRow extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isMobile;
  final double bottomMargin;

  const SectionRow({
    super.key,
    required this.title,
    required this.content,
    required this.isMobile,
    this.bottomMargin = 28,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Padding(
        padding: EdgeInsets.only(bottom: bottomMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 14),
            content,
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: bottomMargin),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 210,
            child: _buildTitle(),
          ),
          const SizedBox(width: 36),
          Expanded(child: content),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: AppTypography.headingMedium().copyWith(
        decoration: TextDecoration.underline,
        decorationThickness: 2.5,
      ),
    );
  }
}

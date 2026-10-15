import 'package:flutter/material.dart';
import '../models/resume_model.dart';
import '../theme/neobrutalist_theme.dart';

class FloatingToolbar extends StatelessWidget {
  final ResumeData currentData;
  final bool isUsingTemplate;
  final bool isEditing;
  final VoidCallback onToggleData;
  final VoidCallback onToggleEdit;
  final VoidCallback onResetData;
  final VoidCallback? onPrint;
  final VoidCallback? onDownloadPdf;

  const FloatingToolbar({
    super.key,
    required this.currentData,
    required this.isUsingTemplate,
    required this.isEditing,
    required this.onToggleData,
    required this.onToggleEdit,
    required this.onResetData,
    this.onPrint,
    this.onDownloadPdf,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x1F000000)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000), // 8% black
            offset: Offset(0, 4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Edit Mode Toggle Button
          _buildPillButton(
            label: isEditing ? '✏️ Edit: ON' : '✏️ Edit: OFF',
            isOutline: !isEditing,
            backgroundColor: isEditing ? AppColors.blueAccent : null,
            textColor: isEditing ? Colors.white : AppColors.ink,
            borderColor: isEditing ? AppColors.blueAccent : AppColors.ink,
            onPressed: onToggleEdit,
          ),

          // Toggle Data Button
          _buildPillButton(
            label: isUsingTemplate ? '👤 Profile' : '📝 Template',
            isOutline: true,
            onPressed: onToggleData,
          ),

          // Print / Save as PDF Button
          _buildPillButton(
            label: '🖨️ Print / PDF',
            isOutline: false,
            onPressed: onPrint ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Print / PDF export available in next slice.'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
          ),

          // Direct Vector PDF Download Button
          _buildPillButton(
            label: '📥 Vector PDF',
            isOutline: true,
            onPressed: onDownloadPdf ??
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Vector PDF export available in next slice.'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
          ),

          // Reset to Default Button
          _buildPillButton(
            label: '↺ Reset',
            isOutline: true,
            onPressed: onResetData,
          ),
        ],
      ),
    );
  }

  Widget _buildPillButton({
    required String label,
    required bool isOutline,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: backgroundColor ??
                (isOutline ? Colors.transparent : AppColors.cardBg),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: borderColor ?? (isOutline ? AppColors.ink : Colors.transparent),
              width: 1.5,
            ),
          ),
          child: Text(
            label,
            style: AppTypography.monoBody(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: textColor ?? AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/neobrutalist_theme.dart';

/// An inline editable text component matching HTML's contenteditable experience.
class InlineEditableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final bool isEditing;
  final ValueChanged<String> onChanged;
  final bool multiline;
  final TextAlign textAlign;
  final TextDecoration? decoration;
  final double? decorationThickness;

  const InlineEditableText({
    super.key,
    required this.text,
    required this.style,
    required this.isEditing,
    required this.onChanged,
    this.multiline = false,
    this.textAlign = TextAlign.start,
    this.decoration,
    this.decorationThickness,
  });

  @override
  State<InlineEditableText> createState() => _InlineEditableTextState();
}

class _InlineEditableTextState extends State<InlineEditableText> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
    _focusNode.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant InlineEditableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text && _controller.text != widget.text) {
      _controller.text = widget.text;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEditing) {
      return Text(
        widget.text,
        style: widget.style.copyWith(
          decoration: widget.decoration,
          decorationThickness: widget.decorationThickness,
        ),
        textAlign: widget.textAlign,
      );
    }

    final isFocused = _focusNode.hasFocus;

    final field = TextField(
      controller: _controller,
      focusNode: _focusNode,
      style: widget.style.copyWith(
        decoration: widget.decoration,
        decorationThickness: widget.decorationThickness,
      ),
      textAlign: widget.textAlign,
      maxLines: widget.multiline ? null : 1,
      minLines: widget.multiline ? 1 : 1,
      keyboardType:
          widget.multiline ? TextInputType.multiline : TextInputType.text,
      onChanged: widget.onChanged,
      cursorColor: AppColors.ink,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );

    final container = MouseRegion(
      cursor: SystemMouseCursors.text,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isFocused
              ? Colors.white.withValues(alpha: 0.85)
              : _isHovered
                  ? Colors.white.withValues(alpha: 0.5)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: isFocused
              ? Border.all(color: AppColors.blueAccent, width: 2)
              : _isHovered
                  ? Border.all(color: const Color(0x40111111), width: 1)
                  : Border.all(color: Colors.transparent, width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: field,
      ),
    );

    if (!widget.multiline) {
      return IntrinsicWidth(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 40),
          child: container,
        ),
      );
    }

    return container;
  }
}

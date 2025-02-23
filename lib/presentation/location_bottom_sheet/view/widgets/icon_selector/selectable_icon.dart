import 'package:flutter/material.dart';

class SelectableIcon extends StatelessWidget {
  const SelectableIcon({
    required this.icon,
    required this.color,
    required this.selectedColor,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });
  final IconData icon;
  final Color color;
  final Color selectedColor;
  final bool isSelected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Widget widget = IconButton(
      icon: Icon(
        icon,
        color: isSelected ? selectedColor : color,
      ),
      onPressed: onPressed,
    );
    if (isSelected) {
      widget = FittedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              width: 2,
              color: selectedColor,
            ),
          ),
          child: widget,
        ),
      );
    }
    return widget;
  }
}

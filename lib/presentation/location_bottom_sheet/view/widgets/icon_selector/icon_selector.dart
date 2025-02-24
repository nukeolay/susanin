import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/constants/icon_constants.dart';
import '../../../../../features/places/domain/entities/icon_entity.dart';
import '../../../../common/susanin_button.dart';
import '../../../../common/susanin_dialog_shell.dart';
import 'selectable_icon.dart';

Future<IconEntity> showIconSelectorDialog({
  required BuildContext context,
  required IconEntity icon,
}) async {
  final selectedIcon = await showDialog<IconEntity>(
        context: context,
        builder: (BuildContext context) {
          return IconSelector(icon: icon);
        },
      ) ??
      icon;
  return selectedIcon;
}

class IconSelector extends StatefulWidget {
  const IconSelector({required this.icon, super.key});
  final IconEntity icon;

  @override
  State<IconSelector> createState() => _IconSelectorState();
}

class _IconSelectorState extends State<IconSelector> {
  late final List<Color> _colors;
  late final List<IconData> _icons;
  late int _colorIndex;
  late int _iconIndex;

  @override
  void initState() {
    super.initState();
    _colors = IconConstants.colors;
    final color = _colors.firstWhereOrNull(
      (color) => color.value == widget.icon.color.value,
    );
    _colorIndex = _colors.indexOf(color ?? _colors.first);
    _icons = IconConstants.icons;
    _iconIndex = _icons.indexOf(widget.icon.iconData);
    if (_iconIndex == -1) _iconIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SusaninDialogShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: _colors.length,
            itemBuilder: (context, index) {
              return SelectableIcon(
                icon: Icons.edit_rounded,
                color: _colors[index],
                selectedColor: _colors[index],
                isSelected: _colorIndex == index,
                onPressed: () => setState(() => _colorIndex = index),
              );
            },
          ),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 50,
              ),
              itemCount: _icons.length,
              itemBuilder: (context, index) {
                return SelectableIcon(
                  icon: _icons[index],
                  color: Theme.of(context).colorScheme.inversePrimary,
                  selectedColor: _colors[_colorIndex],
                  isSelected: _iconIndex == index,
                  onPressed: () {
                    setState(() => _iconIndex = index);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: SusaninButton(
              label: context.s.button_select,
              type: ButtonType.primary,
              onPressed: () {
                Navigator.of(context).pop(
                  IconEntity(
                    iconData: _icons[_iconIndex],
                    color: _colors[_colorIndex],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

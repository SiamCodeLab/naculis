
import 'package:flutter/material.dart';

class SettingsToggleItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const SettingsToggleItem({super.key, 
    required this.icon,
    required this.title,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<SettingsToggleItem> createState() => SettingsToggleItemState();
}

class SettingsToggleItemState extends State<SettingsToggleItem> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        widget.icon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      title: Text(widget.title),
      trailing: Switch(
        value: isToggled,
        onChanged: (value) {
          setState(() => isToggled = value);
          widget.onChanged(value);
        },
      ),
      horizontalTitleGap: 16,
      dense: true,
    );
  }
}

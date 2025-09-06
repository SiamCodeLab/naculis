import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String initialValue;
  final Function(String val) onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          value: selectedValue,
          style: const TextStyle(color: Colors.black),
          items: widget.items.map((e) => DropdownMenuItem(
            value: e,
            child: Text(e, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey)),
          )).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => selectedValue = value);
              widget.onChanged(value);  // <--- notify parent
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFDFF3D5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ),
      ],
    );
  }
}

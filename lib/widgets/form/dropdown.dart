import 'package:app_unicv/common/colors.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final Function(String?)? validator;

  const Dropdown({
    required this.label,
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty) {
      _selectedItem = widget.value ?? widget.items.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 20,
            color: AppColors.mainYellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButtonFormField<String>(
          elevation: 0,
          borderRadius: BorderRadius.circular(8),
          enableFeedback: true,
          icon: const Icon(
            Icons.arrow_drop_down_sharp,
            color: AppColors.mainYellow,
          ),
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: AppColors.black,
            )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10,
            ),
          ),
          isExpanded: true,
          value: widget.value,
          validator: (value) => widget.validator?.call(value),
          onChanged: (newValue) {
            setState(() {
              _selectedItem = newValue!;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(_selectedItem!);
            }
          },
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bourse/Pages/colors.dart';

class MyCardSelectionTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final ValueChanged<T?> onChanged;

  const MyCardSelectionTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: SizedBox(
          child: Column(
            children: [
              InkWell(onTap: () => onChanged(value), child: _customRadioButton),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(6),
      height: 32,
      width: 90,
      decoration: BoxDecoration(
        color: isSelected ? ColorConstants.AppBlueColor : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? ColorConstants.AppBlueColor : Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 8,
          ),
          Text(
            leading,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600]!,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}

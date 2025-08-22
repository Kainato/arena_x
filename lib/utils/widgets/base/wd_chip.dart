import 'package:flutter/material.dart';

class WdChip extends StatelessWidget {
  final String label;
  final Widget? avatar;
  final Color? backgroundColor;

  const WdChip({
    super.key,
    required this.label,
    this.avatar,
    this.backgroundColor,
  });

  const WdChip.value({
    super.key,
    required String label,
    required String value,
    this.avatar,
    this.backgroundColor,
  }) : label = '$label: $value';

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: avatar,
      backgroundColor: backgroundColor,
    );
  }
}

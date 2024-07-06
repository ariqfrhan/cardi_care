import 'package:cardi_care/shared/theme.dart';
import 'package:flutter/material.dart';

class ActivityListTile extends StatelessWidget {
  final String userActivity;
  final String subtitle;
  final String formattedDate;

  const ActivityListTile({
    super.key,
    required this.userActivity,
    required this.subtitle,
    required this.formattedDate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        userActivity,
        style: redText.copyWith(fontSize: 14, fontWeight: bold),
      ),
      subtitle: Text(subtitle),
      trailing: Text(formattedDate),
      shape: LinearBorder.bottom(
        side: const BorderSide(color: Colors.black, width: 0.8),
      ),
      visualDensity: const VisualDensity(vertical: 2),
    );
  }
}

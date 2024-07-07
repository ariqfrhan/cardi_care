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

class PasienListTile extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback? onTap;

  const PasienListTile({
    super.key,
    required this.name,
    required this.email,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap?.call();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: whiteColor,
      title: Text(
        name,
        style: redText.copyWith(fontSize: 14, fontWeight: bold),
      ),
      subtitle: Text(email),
      trailing: const Icon(Icons.arrow_forward_ios),
      visualDensity: const VisualDensity(vertical: 2),
    );
  }
}

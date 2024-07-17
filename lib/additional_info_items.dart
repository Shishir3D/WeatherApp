import 'package:flutter/material.dart';

class AdditionalInfoItems extends StatelessWidget {
  final IconData icon;
  final String info;
  final String value;

  const AdditionalInfoItems({
    super.key,
    required this.icon,
    required this.info,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          icon,
          size: 32,
        ),
        const SizedBox(height: 10),
        Text(info),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

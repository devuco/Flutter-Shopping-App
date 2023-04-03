import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    required this.loginController,
    required this.label,
  }) : super(key: key);

  final TextEditingController loginController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          !GetPlatform.isMobile ? const BoxConstraints(maxWidth: 400) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          controller: loginController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              label: Text(label),
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.orange, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.orange, width: 2)),
              fillColor: Colors.white),
        ),
      ),
    );
  }
}

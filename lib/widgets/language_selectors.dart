import 'package:flutter/material.dart';

import 'custom_dropdown.dart';

class LanguageSelectors extends StatelessWidget {
  const LanguageSelectors({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomDropdown(label: "Translate from"),
        ),
        const SizedBox(width: 10),
        const Icon(
          Icons.swap_horiz,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomDropdown(label: "Translate to"),
        ),
      ],
    );
  }
}

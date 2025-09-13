import 'package:flutter/material.dart';

import 'dialog_card.dart';
import 'document_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DocumentButton(
                onPressed: () => Navigator.pop(context, false),
                isOutlined: true,
                child: const Text('No'),
              ),
              const SizedBox(width: 8),
              DocumentButton(
                child: const Text('Yes'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'document_icon_button_outlined.dart';

class DocumentBackButton extends StatelessWidget {
  const DocumentBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DocumentIconButtonOutlined(
        icon: FontAwesomeIcons.chevronLeft,
        onPressed: () {
          Navigator.maybePop(context);
        },
      ),
    );
  }
}
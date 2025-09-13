import 'package:flutter/material.dart';

import '../models/DCDocument.dart';
import 'document_card.dart';

class DocumentsList extends StatelessWidget {
  const DocumentsList({
    required this.documents,
    super.key,
  });
  final List<DCDocument> documents;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: documents.length,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return DocumentCard(
          document: documents[index],
          isInGrid: false,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}

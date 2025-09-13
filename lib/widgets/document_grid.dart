
import 'package:flutter/material.dart';

import '../models/DCDocument.dart';
import 'document_card.dart';

class DocumentsGrid extends StatelessWidget {
  const DocumentsGrid({
    required this.documents,
    super.key,
  });

  final List<DCDocument> documents;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: documents.length,
      clipBehavior: Clip.none,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, int index) {
          return  DocumentCard(
          document: documents[index],
          isInGrid: true,
        );
      },
    );
  }
}

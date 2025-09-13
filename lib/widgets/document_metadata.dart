import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../change_notifiers/new_document_controller.dart';
import '../core/constants.dart';
import '../core/dialogs.dart';
import '../core/utils.dart';
import '../models/DCDocument.dart';
import 'document_icon_button.dart';
import 'document_tag.dart';

class DocumentMetadata extends StatefulWidget {
  const DocumentMetadata({
    required this.document,
    super.key,
  });
  final DCDocument? document;

  @override
  State<DocumentMetadata> createState() => _documentMetadataState();
}

class _documentMetadataState extends State<DocumentMetadata> {
  late final NewDocumentController newDocumentController;

  @override
  void initState() {
    super.initState();

    newDocumentController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.document != null) ...[
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Last Modified',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray500,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.document!.dateModified),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray900,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Created',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray500,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.document!.dateCreated),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: gray900,
                  ),
                ),
              ),
            ],
          ),
        ],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  const Text(
                    'Tags',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gray500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  DocumentIconButton(
                    icon: FontAwesomeIcons.circlePlus,
                    onPressed: () async {
                      final String? tag =
                          await showNewTagDialog(context: context);

                      if (tag != null) {
                        newDocumentController.addTag(tag);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Selector<NewDocumentController, List<String>>(
                selector: (_, newDocumentController) => newDocumentController.tags,
                builder: (_, tags, __) => tags.isEmpty
                    ? const Text(
                        'No tags added',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gray900,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            tags.length,
                            (index) => DocumentTag(
                              label: tags[index],
                              onClosed: () {
                                newDocumentController.removeTag(index);
                              },
                              onTap: () async {
                                final String? tag = await showNewTagDialog(
                                  context: context,
                                  tag: tags[index],
                                );

                                if (tag != null && tag != tags[index]) {
                                  newDocumentController.updateTag(tag, index);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

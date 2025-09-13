
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../change_notifiers/new_document_controller.dart';
import '../core/constants.dart';
import '../core/dialogs.dart';
import '../widgets/document_back_button.dart';
import '../widgets/document_icon_button_outlined.dart';
import '../widgets/document_metadata.dart';
import '../widgets/document_toolbar.dart';

class NewOrEditDocumentPage extends StatefulWidget {
  const NewOrEditDocumentPage({
    required this.isNewDocument,
    super.key,
  });

  final bool isNewDocument;

  @override
  State<NewOrEditDocumentPage> createState() => _NewOrEditDocumentPageState();
}

class _NewOrEditDocumentPageState extends State<NewOrEditDocumentPage> {
  late final NewDocumentController newDocumentController;
  late final TextEditingController titleController;
  late final QuillController quillController;

  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    newDocumentController = context.read<NewDocumentController>();

    titleController = TextEditingController(text: newDocumentController.title);

    quillController = QuillController.basic()
      ..addListener(() {
        newDocumentController.content = quillController.document;
      });

    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isNewDocument) {
        focusNode.requestFocus();
        newDocumentController.readOnly = false;
      } else {
        newDocumentController.readOnly = true;
        quillController.document = newDocumentController.content;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if (!newDocumentController.canSaveDocument) {
          Navigator.pop(context);
          return;
        }

        final bool? shouldSave = await showConfirmationDialog(
          context: context,
          title: 'Do you want to save the document?',
        );

        if (shouldSave == null) return;

        if (!context.mounted) return;

        if (shouldSave) {
          newDocumentController.saveDocument(context);
        }

        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const DocumentBackButton(),
          title: Text(widget.isNewDocument ? 'New Document' : 'Edit Document'),
          actions: [
            Selector<NewDocumentController, bool>(
              selector: (context, newDocumentController) =>
              newDocumentController.readOnly,
              builder: (context, readOnly, child) => DocumentIconButtonOutlined(
                icon:
                readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
                onPressed: () {
                  newDocumentController.readOnly = !readOnly;

                  if (newDocumentController.readOnly) {
                    FocusScope.of(context).unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
              ),
            ),
            Selector<NewDocumentController, bool>(
              selector: (_, newDocumentController) => newDocumentController.canSaveDocument,
              builder: (_, canSaveDocument, __) => DocumentIconButtonOutlined(
                icon: FontAwesomeIcons.check,
                onPressed: canSaveDocument
                    ? () {
                  newDocumentController.saveDocument(context);
                  Navigator.pop(context);
                }
                    : null,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Selector<NewDocumentController, bool>(
                selector: (context, controller) => controller.readOnly,
                builder: (context, readOnly, child) => TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title here',
                    hintStyle: TextStyle(
                      color: gray300,
                    ),
                    border: InputBorder.none,
                  ),
                  canRequestFocus: !readOnly,
                  onChanged: (newValue) {
                    newDocumentController.title = newValue;
                  },
                ),
              ),
              DocumentMetadata(
                document: newDocumentController.document,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(color: gray500, thickness: 2),
              ),
              Expanded(
                child: Selector<NewDocumentController, bool>(
                  selector: (_, controller) => controller.readOnly,
                  builder: (_, readOnly, __) => Column(
                    children: [
                      Expanded(
                        child: QuillEditor.basic(
                          configurations: QuillEditorConfigurations(
                            controller: quillController,
                            placeholder: 'Document here...',
                            expands: true,
                            // readOnly: readOnly,
                          ),
                          focusNode: focusNode,
                        ),
                      ),
                      if (!readOnly) DocumentToolbar(controller: quillController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

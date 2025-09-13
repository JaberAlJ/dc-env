import 'dart:convert';

import 'package:dc_env/change_notifiers/documents_provider.dart';
import 'package:dc_env/models/DCDocument.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class NewDocumentController extends ChangeNotifier {
  DCDocument? _document;
  set document(DCDocument? value) {
    _document = value;
    _title = _document!.title ?? '';
    _content = Document.fromJson(jsonDecode(_document!.contentJson));
    _tags.addAll(_document!.tags ?? []);
    notifyListeners();
  }

  DCDocument? get document => _document;

  bool _readOnly = false;
  set readOnly(bool value) {
    _readOnly = value;
    notifyListeners();
  }

  bool get readOnly => _readOnly;

  String _title = '';
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get title => _title.trim();

  Document _content = Document();
  set content(Document value) {
    _content = value;
    notifyListeners();
  }

  Document get content => _content;

  final List<String> _tags = [];
  void addTag(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  List<String> get tags => [..._tags];

  void removeTag(int index) {
    _tags.removeAt(index);
    notifyListeners();
  }

  void updateTag(String tag, int index) {
    _tags[index] = tag;
    notifyListeners();
  }

  bool get isNewDocument => _document == null;

  bool get canSaveDocument {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = content.toPlainText().trim().isNotEmpty
        ? content.toPlainText().trim()
        : null;

    bool canSave = newTitle != null || newContent != null;

    if (!isNewDocument) {
      final newContentJson = jsonEncode(content.toDelta().toJson());
      canSave &= newTitle != document!.title ||
          newContentJson != document!.contentJson ||
          !listEquals(tags, document!.tags);
    }

    return canSave;
  }

  void saveDocument(BuildContext context) {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = content.toPlainText().trim().isNotEmpty
        ? content.toPlainText().trim()
        : null;
    final String contentJson = jsonEncode(_content.toDelta().toJson());
    final int now = DateTime.now().microsecondsSinceEpoch;

    final DCDocument document = DCDocument(
      title: newTitle,
      content: newContent,
      contentJson: contentJson,
      dateCreated: isNewDocument ? now : _document!.dateCreated,
      dateModified: now,
      tags: tags,
    );

    final documentsProvider = context.read<DocumentsProvider>();
    isNewDocument ? documentsProvider.addDocument(document) : documentsProvider.updateDocument(document);
  }
}

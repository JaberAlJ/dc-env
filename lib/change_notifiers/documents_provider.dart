import 'package:dc_env/core/extensions.dart';
import 'package:flutter/material.dart';

import '../enums/order_option.dart';
import '../models/DCDocument.dart';

class DocumentsProvider extends ChangeNotifier {
  final List<DCDocument> _documents = [];

  List<DCDocument> get documents =>
      [..._searchTerm.isEmpty ? _documents : _documents.where(_test)]..sort(_compare);

  bool _test(DCDocument document) {
    final term = _searchTerm.toLowerCase().trim();
    final title = document.title?.toLowerCase() ?? '';
    final content = document.content?.toLowerCase() ?? '';
    final tags = document.tags?.map((e) => e.toLowerCase()).toList() ?? [];
    return title.contains(term) ||
        content.contains(term) ||
        tags.deepContains(term);
  }

  int _compare(DCDocument document1, document2) {
    return _orderBy == OrderOption.dateModified
        ? _isDescending
            ? document2.dateModified.compareTo(document1.dateModified)
            : document1.dateModified.compareTo(document2.dateModified)
        : _isDescending
            ? document2.dateCreated.compareTo(document1.dateCreated)
            : document1.dateCreated.compareTo(document2.dateCreated);
  }

  void addDocument(DCDocument document) {
    _documents.add(document);
    notifyListeners();
  }

  void updateDocument(DCDocument document) {
    final index =
        _documents.indexWhere((element) => element.dateCreated == document.dateCreated);
    _documents[index] = document;
    notifyListeners();
  }

  void deleteDocument(DCDocument document) {
    _documents.remove(document);
    notifyListeners();
  }

  // TODO: Export document

  OrderOption _orderBy = OrderOption.dateModified;
  set orderBy(OrderOption value) {
    _orderBy = value;
    notifyListeners();
  }

  OrderOption get orderBy => _orderBy;

  bool _isDescending = true;
  set isDescending(bool value) {
    _isDescending = value;
    notifyListeners();
  }

  bool get isDescending => _isDescending;

  bool _isGrid = true;
  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  bool get isGrid => _isGrid;

  String _searchTerm = '';
  set searchTerm(String value) {
    _searchTerm = value;
    notifyListeners();
  }

  String get searchTerm => _searchTerm;
}

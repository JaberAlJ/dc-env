import 'package:dc_env/change_notifiers/documents_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../core/constants.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final DocumentsProvider documentsProvider;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    documentsProvider = context.read();

    searchController = TextEditingController()
      ..addListener(() {
        documentsProvider.searchTerm = searchController.text;
      });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Search documents...',
        hintStyle: const TextStyle(fontSize: 12),
        prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
        suffixIcon: ListenableBuilder(
          listenable: searchController,
          builder: (context, clearButton) => searchController.text.isNotEmpty
              ? clearButton!
              : const SizedBox.shrink(),
          child: GestureDetector(
            onTap: () {
              searchController.clear();
            },
            child: const Icon(FontAwesomeIcons.circleXmark),
          ),
        ),
        fillColor: white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 42,
          minHeight: 42,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 42,
          minHeight: 42,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: primary,
          ),
        ),
      ),
    );
  }
}

import 'package:dc_env/change_notifiers/new_document_controller.dart';
import 'package:dc_env/change_notifiers/documents_provider.dart';
import 'package:dc_env/pages/new_or_edit_document_page.dart';
import 'package:dc_env/widgets/view_options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../core/dialogs.dart';
import '../models/DCDocument.dart';
import '../services/auth_service.dart';
import '../widgets/no_documents.dart';
import '../widgets/document_fab.dart';
import '../widgets/document_grid.dart';
import '../widgets/document_icon_button_outlined.dart';
import '../widgets/documents_list.dart';
import '../widgets/search_field.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DC.env 📃'),
        actions: [
          DocumentIconButtonOutlined(
            icon: FontAwesomeIcons.rightFromBracket,
            onPressed: () async {
              final bool shouldLogout = await showConfirmationDialog(
                context: context,
                title: 'Do you want to sign out of the app?',
              ) ??
                  false;
              if (shouldLogout) AuthService.logout();
            },
          ),
        ],
      ),
      floatingActionButton: DocumentFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => NewDocumentController(),
                child: const NewOrEditDocumentPage(
                  isNewDocument: true,
                ),
              ),
            ),
          );
        },
      ),
      body: Consumer<DocumentsProvider>(
        builder: (context, documentsProvider, child) {
          final List<DCDocument> documents = documentsProvider.documents;
          return documents.isEmpty && documentsProvider.searchTerm.isEmpty
              ? const NoDocuments()
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SearchField(),
                if (documents.isNotEmpty) ...[
                  const ViewOptions(),
                  Expanded(
                    child: documentsProvider.isGrid
                        ? DocumentsGrid(documents: documents)
                        : DocumentsList(documents: documents),
                  ),
                ] else
                  const Expanded(
                    child: Center(
                      child: Text(
                        'No documents found for your search query!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
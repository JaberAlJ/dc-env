import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/constants.dart';

class DocumentToolbar extends StatelessWidget {
  const DocumentToolbar({
    required this.controller,
    super.key,
  });

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: white,
        border: Border.all(
          color: primary,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: primary,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: QuillToolbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              QuillToolbarHistoryButton(
                controller: controller,
                isUndo: true,
                options: const QuillToolbarHistoryButtonOptions(
                  iconData: FontAwesomeIcons.arrowRotateLeft,
                ),
              ),
              QuillToolbarHistoryButton(
                controller: controller,
                isUndo: false,
                options: const QuillToolbarHistoryButtonOptions(
                  iconData: FontAwesomeIcons.arrowRotateRight,
                ),
              ),
              QuillToolbarSelectHeaderStyleDropdownButton(
                controller: controller,
              ),
              QuillToolbarToggleStyleButton(
                controller: controller,
                attribute: Attribute.bold,
                options: const QuillToolbarToggleStyleButtonOptions(
                  iconData: FontAwesomeIcons.bold,
                ),
              ),
              QuillToolbarToggleStyleButton(
                controller: controller,
                attribute: Attribute.italic,
                options: const QuillToolbarToggleStyleButtonOptions(
                  iconData: FontAwesomeIcons.italic,
                ),
              ),
              QuillToolbarToggleStyleButton(
                controller: controller,
                attribute: Attribute.underline,
                options: const QuillToolbarToggleStyleButtonOptions(
                  iconData: FontAwesomeIcons.underline,
                ),
              ),
              QuillToolbarToggleStyleButton(
                controller: controller,
                attribute: Attribute.strikeThrough,
                options: const QuillToolbarToggleStyleButtonOptions(
                  iconData: FontAwesomeIcons.strikethrough,
                ),
              ),
              QuillToolbarColorButton(
                controller: controller,
                isBackground: false,
                options: const QuillToolbarColorButtonOptions(
                  iconData: FontAwesomeIcons.palette,
                ),
              ),
              QuillToolbarColorButton(
                controller: controller,
                isBackground: true,
                options: const QuillToolbarColorButtonOptions(
                  iconData: FontAwesomeIcons.fillDrip,
                ),
              ),
              QuillToolbarClearFormatButton(
                controller: controller,
                options: const QuillToolbarClearFormatButtonOptions(
                  iconData: FontAwesomeIcons.textSlash,
                ),
              ),
              QuillToolbarToggleStyleButton(
                controller: controller,
                attribute: Attribute.ol,
                options: const QuillToolbarToggleStyleButtonOptions(
                  iconData: FontAwesomeIcons.listOl,
                ),
              ),
              QuillToolbarToggleStyleButton(
                controller: controller,
                attribute: Attribute.ul,
                options: const QuillToolbarToggleStyleButtonOptions(
                  iconData: FontAwesomeIcons.listUl,
                ),
              ),
              QuillToolbarToggleStyleButton(
                controller: controller,
                attribute: Attribute.subscript,
                options: const QuillToolbarToggleStyleButtonOptions(
                  iconData: FontAwesomeIcons.subscript,
                ),
              ),
              QuillToolbarToggleStyleButton(
                controller: controller,
                attribute: Attribute.superscript,
                options: const QuillToolbarToggleStyleButtonOptions(
                  iconData: FontAwesomeIcons.superscript,
                ),
              ),
              QuillToolbarIndentButton(
                controller: controller,
                isIncrease: true,
                // TODO: Edit the Indentation icon
                // options: const QuillToolbarIndentButtonOptions(
                //   iconData: FontAwesomeIcons.indent,
                // ),
              ),
              QuillToolbarIndentButton(
                controller: controller,
                isIncrease: false,
                // TODO: Edit the Indentation icon
                // options: const QuillToolbarIndentButtonOptions(
                //   iconData: FontAwesomeIcons.indent,
                // ),
              ),
              QuillToolbarLinkStyleButton(
                controller: controller,
              ),
              // QuillToolbarSelectAlignmentButton(controller: controller),
              QuillToolbarFontFamilyButton(
                controller: controller,
              ),
              QuillToolbarFontSizeButton(
                controller: controller,
              ),
              QuillToolbarSearchButton(
                controller: controller,
                options: const QuillToolbarSearchButtonOptions(
                  iconData: FontAwesomeIcons.magnifyingGlass,
                ),
              ),
            //   TODO: Add more buttons on the QuillToolbar
            ],
          ),
        ),
      ),
    );
  }
}

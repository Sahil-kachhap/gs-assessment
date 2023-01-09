import 'package:flutter/material.dart';
import 'package:rider_app/screens/story_screen.dart';
import 'package:rider_app/widgets/document_button.dart';

class DocumentField extends StatelessWidget {
  final String? documentName;
  final bool? gotDocument;
  final VoidCallback? onDocumentRequested;
  final String? filePath;

  const DocumentField({
    Key? key,
    required this.documentName,
    required this.gotDocument,
    required this.onDocumentRequested,
    this.filePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid),
        ),
        child: GestureDetector(
          onTap: onDocumentRequested,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: gotDocument,
                    onChanged: (value) {},
                  ),
                  Text(documentName!),
                ],
              ),
              if (gotDocument!)
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryScreen(
                              filePath: filePath!,
                            ),
                          ),
                        ),
                        child: const DocumentButton(
                          title: "View",
                        ),
                      ),
                      const DocumentButton(
                        title: "Edit",
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}



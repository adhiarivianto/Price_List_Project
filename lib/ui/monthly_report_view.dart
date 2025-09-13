import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:price_list/components/base_card.dart';

class MonthlyReportView extends StatefulWidget {
  const MonthlyReportView({super.key});

  @override
  State<StatefulWidget> createState() => _MonthlyReportViewState();
}

class _MonthlyReportViewState extends State<MonthlyReportView> {
  Uint8List? imageBytes;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      if (result.files.single.bytes != null) {
        // bytes -> usually for browser
        setState(() {
          imageBytes = result.files.single.bytes!;
        });
      } else if (result.files.single.path != null) {
        //path -> works for desktop app
        setState(() {
          imageBytes = File(result.files.single.path!).readAsBytesSync();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      isExpanded: false,
      cardContent: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageBytes != null)
            InteractiveViewer(
              child: Image.memory(imageBytes!, fit: BoxFit.cover),
            )
          else
            const Text("No image selected"),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: pickImage, child: const Text("Pick Image")),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  // const FileScreen({Key? key}) : super(key: key);
  FilePickerResult? result;

  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  pickedFile();
                },
                child: Text("Pick")),
            Container(
              height: 100,
              width: 100,
              child: file == null
                  ? Container()
                  : Image.file(
                      File(
                        file!.path.toString(),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  void pickedFile() async {
    result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) return;
    file = result?.files.first;
    setState(() {});
  }
}

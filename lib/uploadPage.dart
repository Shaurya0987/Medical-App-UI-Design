import 'dart:io';
import 'package:bdver/Services/storage.service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart'; 
// ❗ Replace your_app with your real project name

class StorageUIPage extends StatefulWidget {
  const StorageUIPage({super.key});

  @override
  State<StorageUIPage> createState() => _StorageUIPageState();
}

class _StorageUIPageState extends State<StorageUIPage> {
  final StorageService storage = StorageService();
  final String bucket = "myFiles"; // your bucket name

  File? _pickedFile;
  List<String> fileList = [];

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  // ----------------------------
  // Pick image
  // ----------------------------
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => _pickedFile = File(file.path));
    }
  }

  // ----------------------------
  // Pick ANY file (PDF, image, doc, video)
  // ----------------------------
  Future pickAnyFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      setState(() => _pickedFile = File(result.files.single.path!));
    }
  }

  // ----------------------------
  // Upload selected file
  // ----------------------------
  Future uploadFile() async {
    if (_pickedFile == null) return;

    final url = await storage.uploadFile(_pickedFile!, bucket);

    if (url != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Uploaded Successfully!")),
      );
      loadFiles(); // refresh file list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload Failed")),
      );
    }
  }

  // ----------------------------
  // Load all files from "uploads/" folder
  // ----------------------------
  Future loadFiles() async {
    final files = await storage.listFiles(bucket, "uploads");
    setState(() => fileList = files);
  }

  // ----------------------------
  // Delete a file
  // ----------------------------
  Future deleteFile(String fileName) async {
    final success = await storage.deleteFile(bucket, "uploads/$fileName");

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Deleted $fileName")),
      );
      loadFiles();
    }
  }

  // ----------------------------
  // Download a file
  // ----------------------------
  Future downloadAFile(String fileName) async {
    final file = await storage.downloadFile(
      bucket,
      "uploads/$fileName",
      fileName,
    );

    if (file != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downloaded to: ${file.path}")),
      );
    }
  }

  // ==========================================================
  // U I
  // ==========================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supabase Storage Manager")),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // ---------------- PICK + UPLOAD ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: pickImage, child: const Text("Pick Image")),
              ElevatedButton(
                  onPressed: pickAnyFile, child: const Text("Pick Any File")),
              ElevatedButton(
                  onPressed: uploadFile, child: const Text("Upload")),
            ],
          ),

          const SizedBox(height: 20),
          const Text(
            "Uploaded Files",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // ---------------- FILE LIST ----------------
          Expanded(
            child: fileList.isEmpty
                ? const Center(child: Text("No files found"))
                : ListView.builder(
                    itemCount: fileList.length,
                    itemBuilder: (context, index) {
                      final file = fileList[index];

                      return Card(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.insert_drive_file),
                          title: Text(file),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Download
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () => downloadAFile(file),
                              ),

                              // Delete
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteFile(file),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}

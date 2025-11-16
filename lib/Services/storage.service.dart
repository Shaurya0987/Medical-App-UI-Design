import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final supabase = Supabase.instance.client;

  // -------------------------------
  // 1️⃣ Upload File
  // -------------------------------
  Future<String?> uploadFile(File file, String bucket) async {
    try {
      final fileName =
          "uploads/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}";

      await supabase.storage.from(bucket).upload(
            fileName,
            file,
            fileOptions: const FileOptions(upsert: true),
          );

      return supabase.storage.from(bucket).getPublicUrl(fileName);
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  // -------------------------------
  // 2️⃣ List Files
  // -------------------------------
  Future<List<String>> listFiles(String bucket, String folder) async {
    try {
      final result = await supabase.storage.from(bucket).list(path: folder);
      return result.map((e) => e.name).toList();
    } catch (e) {
      print("List error: $e");
      return [];
    }
  }

  // -------------------------------
  // 3️⃣ Delete a File
  // -------------------------------
  Future<bool> deleteFile(String bucket, String filePath) async {
    try {
      await supabase.storage.from(bucket).remove([filePath]);
      return true;
    } catch (e) {
      print("Delete error: $e");
      return false;
    }
  }

  // -------------------------------
  // 4️⃣ Download File
  // -------------------------------
  Future<File?> downloadFile(
      String bucket, String storagePath, String saveName) async {
    try {
      final bytes = await supabase.storage.from(bucket).download(storagePath);

      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/$saveName");
      await file.writeAsBytes(bytes);

      return file;
    } catch (e) {
      print("Download error: $e");
      return null;
    }
  }
}

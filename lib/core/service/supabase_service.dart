import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient supabase = Supabase.instance.client;


  Future<String?> uploadImage({
    required Uint8List fileBytes,
    required String fileExtension, // مثلا: 'jpg' أو 'png'
  }) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      final response = await supabase.storage.from('products').uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: false,
            ),
          );

      if (response.isEmpty) {
        throw Exception('Upload failed');
      }

      return supabase.storage.from('products').getPublicUrl(fileName);
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> deleteImageFromUrl({required String imageUrl}) async {
    try {
      if (imageUrl.isEmpty) {
        throw Exception('Image URL is empty');
      }

      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;

      final bucketIndex = pathSegments.indexOf('products');
      if (bucketIndex == -1 || bucketIndex + 1 >= pathSegments.length) {
        throw Exception('Invalid image URL format: $imageUrl');
      }

      final filePath = pathSegments.sublist(bucketIndex + 1).join('/');

      await supabase.storage.from('products').remove([filePath]);

      // if (response.isNotEmpty) {
      //   throw Exception('Failed to delete image: ${response.first}');
      // }
    } catch (e) {
      throw Exception('Error deleting image: $e');
    }
  }
}

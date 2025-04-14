import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';


class SupabaseService {
   final SupabaseClient supabase = Supabase.instance.client;



   Future<String?> uploadImage({required File file}) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}';
      
      // Upload the file
      final response = await supabase.storage.from('products').upload(
        fileName, 
        file, 
        fileOptions:const FileOptions(cacheControl: '3600', upsert: false),
      );

      // Check for errors
      if (response.isEmpty) {
        throw Exception('Upload failed');
      }

      // Get Public URL
      String imageUrl = supabase.storage.from('products').getPublicUrl(fileName);
      return imageUrl;
    } catch (e) {
    throw Exception('Error uploading image: $e');
    }
  }



  

    Future<void> deleteImageFromUrl({required String imageUrl}) async {
  try {
    // Extract file path from the URL
    final uri = Uri.parse(imageUrl);
    final pathSegments = uri.pathSegments;
    
    // Find the index of 'products' (the bucket name) and get the remaining path
    final bucketIndex = pathSegments.indexOf('products');
    if (bucketIndex == -1 || bucketIndex + 1 >= pathSegments.length) {
      throw Exception('Invalid image URL');
    }
    
    // Construct the file path (everything after 'products/')
    final filePath = pathSegments.sublist(bucketIndex + 1).join('/');

    // Delete the file from Supabase Storage
    final response = await supabase.storage.from('products').remove([filePath]);

    if (response.isNotEmpty) {
      throw Exception('Failed to delete image: ${response.first}');
    }

    print('Image deleted successfully');
  } catch (e) {
    print('Error deleting image: $e');
  }
}

}

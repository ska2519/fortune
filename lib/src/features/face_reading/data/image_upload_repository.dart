import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'image_upload_repository.g.dart';

/// Class for uploading images to Firebase Storage
class ImageUploadRepository {
  ImageUploadRepository();

  // 4. compress Uint8List and get another Uint8List.
  Future<Uint8List> compressImage(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 512,
      minWidth: 512,
      format: CompressFormat.jpeg,
    );
    return result;
  }

  // Future<String> uploadProductImageFromSelectFile() async {
  //   FilePickerResult? filePickerResult =
  //       await FilePicker.platform.pickFiles(type: FileType.image);

  //   if (filePickerResult?.files.first.bytes != null) {
  //     final bytes = filePickerResult!.files.first.bytes!;
  //     final webpCompressBytes = await compressByWebp(bytes);

  //     const uuid = Uuid();
  //     final result = await uploadAsset(
  //       uuid.v4(),
  //       uint8bytes: webpCompressBytes,
  //     );
  //     // return download URL
  //     return result.ref.getDownloadURL();
  //   } else {
  //     // User canceled the picker
  //     throw Exception('No file selected');
  //   }
  // }

  Future<List<Uint8List>> pickFilesToUnit8List() async {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      // allowCompression: false,
    );
    if (filePickerResult != null) {
      List<Uint8List> files = [];
      for (final file in filePickerResult.files) {
        final bytes = file.bytes!;
        final webpCompressBytes = await compressImage(bytes);
        files.add(webpCompressBytes);
      }
      return files;
    } else {
      // User canceled the picker
      throw Exception('No file selected');
    }
  }

  /// Upload an image asset to Firebase Storage and returns the download URL
  // Future<String> uploadProductImageFromAsset(
  //     String id, String assetPath) async {
  //   // load asset byte data from bundle
  //   final byteData = await rootBundle.load(assetPath);
  //   final webpCompressBytes =
  //       await compressByWebp(byteData.buffer.asUint8List());
  //   // Extract filename
  //   // Example name: assets/products/bruschetta-plate.jpg
  //   // final components = assetPath.split('/');
  //   final filename = '${id}_1';
  //   // upload to Firebase Storage
  //   final result = await uploadAsset(uint8bytes: webpCompressBytes, filename);

  //   // return download URL
  //   return result.ref.getDownloadURL();
  // }

  // Future<String> productImageUrlsFromUnit8List(
  //   String filename, {
  //   Uint8List? uint8bytes,
  // }) async {
  //   final result = await uploadAsset(uint8bytes: uint8bytes, filename);

  //   // return download URL
  //   return result.ref.getDownloadURL();
  // }

  // UploadTask uploadAsset(
  //   String filename, {
  //   Uint8List? uint8bytes,
  //   ByteData? byteData,
  // }) {
  //   late Uint8List bytes;
  //   if (byteData != null) {
  //     bytes = byteData.buffer
  //         .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  //   }
  //   final ref = _storage.ref('products/$filename');
  //   return ref.putData(
  //     uint8bytes ?? bytes,
  //     SettableMetadata(contentType: 'image/webp'),
  //   );
  // }

  /// Delete the product image from Firebase storage
  // Future<void> deleteProductImage(String imageUrl) async {
  //   // * This line will throw an exception when running with the Firebase local emulator.
  //   // * 'parts != null': url could not be parsed, ensure it's a valid storage url
  //   // * More info here: https://github.com/firebase/flutterfire/issues/7019
  //   try {
  //     return await _storage.refFromURL(imageUrl).delete();
  //   } on FirebaseException catch (e) {
  //     // * This error is thrown when the image is not found.
  //     switch (e.code) {
  //       case 'object-not-found':
  //         return Future<void>.value();
  //       default:
  //         rethrow;
  //     }
  //   }
  // }

  // Future<void> deleteProductImages(List<String> imageUrls) async {
  //   // * This line will throw an exception when running with the Firebase local emulator.
  //   // * 'parts != null': url could not be parsed, ensure it's a valid storage url
  //   // * More info here: https://github.com/firebase/flutterfire/issues/7019
  //   try {
  //     for (final imageUrl in imageUrls) {
  //       await _storage.refFromURL(imageUrl).delete();
  //     }
  //   } on FirebaseException catch (e) {
  //     // * This error is thrown when the image is not found.
  //     switch (e.code) {
  //       case 'object-not-found':
  //         return Future<void>.value();
  //       default:
  //         rethrow;
  //     }
  //   }
  // }
}

// @riverpod
// ImageUploadRepository imageUploadRepository(ImageUploadRepositoryRef ref) {
//   return ImageUploadRepository();
// }

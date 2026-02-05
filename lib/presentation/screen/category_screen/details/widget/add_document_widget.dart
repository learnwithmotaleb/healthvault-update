import 'dart:io';
import 'package:flutter/material.dart';
import 'package:healthvault/utils/app_colors/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class DocumentPickerField extends StatelessWidget {
  final double boxSize;
  final int maxImages;
  final ValueChanged<File> onPickImage;

  const DocumentPickerField({
    super.key,
    this.boxSize = 100,
    this.maxImages = 10,
    required this.onPickImage,
  });

  Future<void> _showImageSourceSheet(BuildContext context) async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primaryColor),
              title: const Text("Gallery"),
              onTap: () async {
                final XFile? file =
                await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
                Navigator.pop(ctx);
                if (file != null) {
                  onPickImage(File(file.path));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primaryColor),
              title: const Text("Camera"),
              onTap: () async {
                final XFile? file =
                await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
                Navigator.pop(ctx);
                if (file != null) {
                  onPickImage(File(file.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImageSourceSheet(context),
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: Icon(Icons.add, size: 36, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

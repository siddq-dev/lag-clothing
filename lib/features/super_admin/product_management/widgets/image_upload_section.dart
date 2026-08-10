import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:lag_clothing/models/product_image_model.dart';
import 'package:lag_clothing/services/firebase_storage_service.dart';
import 'package:lag_clothing/providers/product_management_provider.dart';

class ImageUploadSection extends StatefulWidget {
  const ImageUploadSection({super.key});

  @override
  State<ImageUploadSection> createState() => _ImageUploadSectionState();
}

class _ImageUploadSectionState extends State<ImageUploadSection> {
  static const int _maxImages = 5;
  static const int _maxSizeInBytes = 2 * 1024 * 1024;

  static const List<String> _allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];

  /// Local images currently being uploaded.
  ///
  /// Key   = temporary ID
  /// Value = selected XFile
  final Map<String, XFile> _uploadingImages = {};

  /// Keeps track of which local image is currently uploading.
  final Set<String> _uploadingIds = {};

  //==========================================================
  // Snackbar
  //==========================================================

  void _showMessage(BuildContext context, String message) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  //==========================================================
  // Pick Image
  //==========================================================

  Future<void> _pickImage(BuildContext context) async {
    final provider = context.read<ProductManagementProvider>();

    //--------------------------------------------------------
    // Maximum 5 images
    //--------------------------------------------------------

    final currentCount = provider.form.images.length + _uploadingImages.length;

    if (currentCount >= _maxImages) {
      _showMessage(context, "You can upload a maximum of $_maxImages images.");
      return;
    }

    //--------------------------------------------------------
    // Pick image
    //--------------------------------------------------------

    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    //--------------------------------------------------------
    // Validate extension
    //--------------------------------------------------------

    final extension = image.name.split('.').last.toLowerCase();

    if (!_allowedExtensions.contains(extension)) {
      _showMessage(
        context,
        "Unsupported image type. Please use JPG, JPEG, PNG, or WEBP.",
      );
      return;
    }

    //--------------------------------------------------------
    // Validate size
    //--------------------------------------------------------

    final bytes = await image.readAsBytes();

    if (bytes.length > _maxSizeInBytes) {
      _showMessage(context, "Image size must not exceed 2 MB.");
      return;
    }

    //--------------------------------------------------------
    // Temporary ID
    //--------------------------------------------------------

    final temporaryId = DateTime.now().microsecondsSinceEpoch.toString();

    //--------------------------------------------------------
    // IMPORTANT:
    // Immediately show selected image in the UI.
    //--------------------------------------------------------

    setState(() {
      _uploadingImages[temporaryId] = image;
      _uploadingIds.add(temporaryId);
    });

    //--------------------------------------------------------
    // Upload to Firebase Storage
    //--------------------------------------------------------

    try {
      final imageUrl = await FirebaseStorageService.uploadProductImage(image);

      if (!mounted) return;

      //------------------------------------------------------
      // Create ProductImageModel after successful upload
      //------------------------------------------------------

      final productImage = ProductImageModel(
        id: temporaryId,
        imageUrl: imageUrl,
        isPrimary: provider.form.images.isEmpty,
      );

      //------------------------------------------------------
      // Add Firebase image to provider
      //------------------------------------------------------

      provider.addImage(productImage);

      //------------------------------------------------------
      // Remove local uploading preview
      //------------------------------------------------------

      setState(() {
        _uploadingImages.remove(temporaryId);
        _uploadingIds.remove(temporaryId);
      });

      _showMessage(context, "Image uploaded successfully.");
    } catch (e) {
      if (!mounted) return;

      //------------------------------------------------------
      // Upload failed
      //------------------------------------------------------

      setState(() {
        _uploadingImages.remove(temporaryId);
        _uploadingIds.remove(temporaryId);
      });

      _showMessage(context, e.toString().replaceFirst("Exception: ", ""));
    }
  }

  //==========================================================
  // Remove Firebase Image
  //==========================================================

  void _removeUploadedImage(BuildContext context, ProductImageModel image) {
    final provider = context.read<ProductManagementProvider>();

    provider.removeImage(image);

    _showMessage(context, "Image removed.");
  }

  //==========================================================
  // Build
  //==========================================================

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductManagementProvider>();

    final images = provider.form.images;

    final totalCount = images.length + _uploadingImages.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //================================================
            // Title
            //================================================
            const Text(
              "Product Images",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            //================================================
            // Placeholder / Instructions
            //================================================
            const Text(
              "Upload 1 to 5 product images.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 4),

            const Text(
              "Maximum file size: 2 MB per image.",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 4),

            const Text(
              "Supported formats: JPG, JPEG, PNG, WEBP.",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 25),

            //================================================
            // Add Image Button
            //================================================
            ElevatedButton.icon(
              onPressed: totalCount >= _maxImages
                  ? null
                  : () => _pickImage(context),
              icon: const Icon(Icons.image),
              label: Text("Add Image ($totalCount/$_maxImages)"),
            ),

            const SizedBox(height: 25),

            //================================================
            // Empty State
            //================================================
            if (images.isEmpty && _uploadingImages.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("No images selected."),
                ),
              ),

            //================================================
            // Images
            //================================================
            if (images.isNotEmpty || _uploadingImages.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: images.length + _uploadingImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  //================================================
                  // Uploaded Firebase images
                  //================================================

                  if (index < images.length) {
                    final image = images[index];

                    return _UploadedImageCard(
                      image: image,
                      onRemove: () {
                        _removeUploadedImage(context, image);
                      },
                    );
                  }

                  //================================================
                  // Local uploading images
                  //================================================

                  final uploadingIndex = index - images.length;

                  final entries = _uploadingImages.entries.toList();

                  final entry = entries[uploadingIndex];

                  return _UploadingImageCard(image: entry.value);
                },
              ),
          ],
        ),
      ),
    );
  }
}

//==============================================================
// Uploaded Image Card
//==============================================================

class _UploadedImageCard extends StatelessWidget {
  const _UploadedImageCard({required this.image, required this.onRemove});

  final ProductImageModel image;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) {
                  return child;
                }

                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, size: 40),
                );
              },
            ),
          ),
        ),

        //========================================================
        // Remove button
        //========================================================
        Positioned(
          top: 5,
          right: 5,
          child: InkWell(
            onTap: onRemove,
            child: const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: Icon(Icons.close, size: 15, color: Colors.white),
            ),
          ),
        ),

        //========================================================
        // Primary
        //========================================================
        if (image.isPrimary)
          Positioned(
            left: 5,
            bottom: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "Primary",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

//==============================================================
// Uploading Local Image Card
//==============================================================

class _UploadingImageCard extends StatelessWidget {
  const _UploadingImageCard({required this.image});

  final XFile image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image.path,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return FutureBuilder(
                  future: image.readAsBytes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Image.memory(snapshot.data!, fit: BoxFit.cover);
                  },
                );
              },
            ),
          ),
        ),

        //========================================================
        // Upload overlay
        //========================================================
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "Uploading...",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

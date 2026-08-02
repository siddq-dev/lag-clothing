import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '/models/product_image_model.dart';
import '/services/firebase_storage_service.dart';


import '/providers/product_management_provider.dart';

class ImageUploadSection extends StatelessWidget {
  const ImageUploadSection({super.key});

Future<void> _pickImage(
  BuildContext context,
) async {
  final picker = ImagePicker();

  final image = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 85,
  );

  if (image == null) return;

  final provider =
      context.read<ProductManagementProvider>();

  try {
    final imageUrl =
        await FirebaseStorageService
            .uploadProductImage(image);

    provider.addImage(
      ProductImageModel(
        imageUrl: imageUrl,
        isPrimary:
            provider.form.images.isEmpty, id: '',
      ),
    );
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ProductManagementProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Product Images",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: () =>
                  _pickImage(context),
              icon:
                  const Icon(Icons.image),
              label:
                  const Text("Add Image"),
            ),

            const SizedBox(height: 25),

            if (provider.form.images.isEmpty)
              const Text(
                "No images selected.",
              ),

            if (provider.form.images.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount:
                    provider.form.images.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder:
                    (context, index) {
                  final image =
                      provider
                          .form.images[index];

                  return Stack(
                    children: [

                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                            10,
                          ),
                          child: Image.network(
  image.imageUrl,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  },
  errorBuilder: (
    context,
    error,
    stackTrace,
  ) {
    return Container(
      color: Colors.grey.shade200,
      child: const Icon(
        Icons.broken_image,
        size: 40,
      ),
    );
  },
)
                        ),
                      ),

                      Positioned(
                        top: 5,
                        right: 5,
                        child: InkWell(
                          onTap: () {
                            provider
                                .removeImage(
                              image,
                            );
                          },
                          child:
                              const CircleAvatar(
                            radius: 12,
                            backgroundColor:
                                Colors.red,
                            child: Icon(
                              Icons.close,
                              size: 15,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
                      ),

                      if (image.isPrimary)
                        Positioned(
                          left: 5,
                          bottom: 5,
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration:
                                BoxDecoration(
                              color:
                                  Colors.green,
                              borderRadius:
                                  BorderRadius.circular(
                                6,
                              ),
                            ),
                            child:
                                const Text(
                              "Primary",
                              style:
                                  TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
import 'dart:io';

import 'package:coffee_shop/bloc/coffee_bloc/coffee_bloc.dart';
import 'package:coffee_shop/data/models/coffee_fields.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/show_loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

void showImageDialog({
  required ImagePicker picker,
  required BuildContext context,
  required ValueChanged<String> valueChanged,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.itemColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  onTap: () async {
                    await _getFromCamera(
                        picker: picker,
                        context: context,
                        valueChanged: (v) {
                          valueChanged(v);
                        });
                    if (context.mounted) Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.camera_alt,
                    color: AppColors.buttonColor,
                  ),
                  title: const Text(
                    "Select from Camera",
                    style:
                        TextStyle(color: AppColors.buttonColor, fontSize: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white, width: 2)),
                child: ListTile(
                  onTap: () async {
                    await _getFromGallery(
                        picker: picker,
                        context: context,
                        valueChanged: (v) {
                          valueChanged(v);
                        });
                    if (context.mounted) Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.photo,
                    color: AppColors.buttonColor,
                  ),
                  title: const Text(
                    "Select from Gallery",
                    style:
                        TextStyle(color: AppColors.buttonColor, fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

Future<void> _getFromCamera({
  required ImagePicker picker,
  required BuildContext context,
  required ValueChanged<String> valueChanged,
}) async {
  XFile? xFile = await picker.pickImage(
    source: ImageSource.camera,
    maxHeight: 512,
    maxWidth: 512,
  );

  if (xFile != null && context.mounted) {
    showLoading(context: context);

    UniversalData data = await imageUploader(xFile);
    if (!context.mounted) return;
    context.read<CoffeeBloc>().add(
        UpdateCoffeeField(value: data.data, fieldKey: CoffeeFields.imageUrl));
    hideLoading(context: context);
    valueChanged(xFile.path);
  }
}

Future<void> _getFromGallery(
    {required ImagePicker picker,
    required BuildContext context,
    required ValueChanged<String> valueChanged}) async {
  XFile? xFile = await picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 512,
    maxWidth: 512,
  );
  if (xFile != null && context.mounted) {
    showLoading(context: context);
    UniversalData data = await imageUploader(xFile);
    if (!context.mounted) return;
    context.read<CoffeeBloc>().add(
        UpdateCoffeeField(value: data.data, fieldKey: CoffeeFields.imageUrl));
    hideLoading(context: context);

    valueChanged(xFile.path);
    debugPrint("Success");
  }
}

Future<UniversalData> imageUploader(XFile xFile) async {
  String downloadUrl = "";
  try {
    final storageRef = FirebaseStorage.instance.ref();
    var imageRef = storageRef.child("images/profileImages/${xFile.name}");
    await imageRef.putFile(File(xFile.path));
    downloadUrl = await imageRef.getDownloadURL();

    return UniversalData(data: downloadUrl);
  } catch (error) {
    return UniversalData(error: error.toString());
  }
}

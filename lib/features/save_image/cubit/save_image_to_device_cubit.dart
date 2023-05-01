import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'save_image_to_device_state.dart';

class SaveImageToDeviceCubit extends Cubit<SaveImageToDeviceState> {
  SaveImageToDeviceCubit() : super(const SaveImageToDeviceState());

  Future<void> onSaveImage(File? selectedImage) async {
    final result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.manageExternalStorage] == PermissionStatus.granted) {
      if (selectedImage == null) return;

      Directory? externalDirectory = await getExternalStorageDirectory();
      final imagePath = '${externalDirectory!.path}/my_image.png';
      GallerySaver.saveImage(
        imagePath,
        albumName: 'Media',
      );

      try {
        await selectedImage.copy(imagePath);
        emit(state.copyWith(isSaved: true));
      } catch (e) {
        e.toString();
      }
    }
  }
}

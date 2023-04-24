import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

part 'save_image_to_device_state.dart';

class SaveImageToDeviceCubit extends Cubit<SaveImageToDeviceState> {
  SaveImageToDeviceCubit() : super(const SaveImageToDeviceState());

  Future<void> onSaveImage(String? selectedImage) async {
    Directory? externalDirectory = await getExternalStorageDirectory();
    File file = File(
      path.join(externalDirectory!.path),
    );
    try {
      await file.writeAsString(selectedImage!);
      emit(state.copyWith(isSaved: true));
    } catch (e) {
      emit(state.copyWith(isSaved: false));
    }
  }
}

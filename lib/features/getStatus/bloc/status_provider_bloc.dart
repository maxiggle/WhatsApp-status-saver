import 'dart:async';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_saver/get_file_path.dart';
import 'package:path/path.dart' as path;

part 'status_provider_event.dart';
part 'status_provider_state.dart';

class StatusProviderBloc
    extends Bloc<StatusProviderEvent, StatusProviderState> {
  StatusProviderBloc() : super(const StatusProviderState()) {
    on<GetStatus>(_onGetStatus);
    on<GetStatus>(_onSaveImage);
  }

  Future<void> _onGetStatus(
    GetStatus event,
    Emitter<StatusProviderState> emit,
  ) async {
    final result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.manageExternalStorage] == PermissionStatus.granted) {
      emit(state.copyWith(isLoading: true));
      final directory = Directory(AppConstant.WHATSAPP_PATH);
      final directoryExists = await directory.exists();

      if (!directoryExists) return;

      return emit.forEach(
        directory.list(),
        onData: ((data) {
          if (data.path.endsWith(event.ext)) {
            final images = state.images.toList();
            images.add(data);
            emit(state.copyWith(isLoading: false));
            return state.copyWith(images: images);
          }
          return state;
        }),
      );
    }
  }

  Future<void> _onSaveImage( GetStatus event,
      Emitter<StatusProviderState> emit,String? selectedImage,) async {
    final image = selectedImage;

    final result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();
    if (result[Permission.storage] != PermissionStatus.granted ||
        result[Permission.manageExternalStorage] != PermissionStatus.granted) {
      return;
    }
    Directory? externalDirectory = await getExternalStorageDirectory();
    File file = File(
      path.join(externalDirectory!.path, path.basename('image')),
    );
    try {
      await file.writeAsString(image!);
      emit(state.copyWith(isSaved: true));
    } catch (e) {
      emit(state.copyWith(isSaved: false));
    }
  }
}

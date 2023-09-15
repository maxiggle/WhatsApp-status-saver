import 'dart:async';
import 'dart:io';
import 'dart:developer';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_saver/get_file_path.dart';
part 'status_provider_event.dart';
part 'status_provider_state.dart';

class StatusProviderBloc
    extends Bloc<StatusProviderEvent, StatusProviderState> {
  StatusProviderBloc() : super(const StatusProviderState()) {
    on<GetStatus>(_onGetStatus);
    on<SaveStatus>(_onSaveStatus);
  }

  Future<void> _onGetStatus(
    GetStatus event,
    Emitter<StatusProviderState> emit,
  ) async {
    PermissionStatus permissionStatusStorage =
        await Permission.storage.request();

    PermissionStatus permissionStatusManageExternalStorage =
        await Permission.manageExternalStorage.request();

    if (permissionStatusStorage == PermissionStatus.granted ||
        permissionStatusManageExternalStorage == PermissionStatus.granted) {
      emit(state.copyWith(isLoading: true));
      final directory = Directory(AppConstant.WHATSAPP_PATH);
      final directoryExists = await directory.exists();

      if (!directoryExists) {
        // Handle the case where the directory doesn't exist
        return;
      }

      // Use for...await...in to iterate over the directory listing and add images
      final images = state.images.toList();
      await for (final data in directory.list()) {
        if (data.path.endsWith(event.ext)) {
          images.add(data);
          emit(state.copyWith(isLoading: false, images: images));
        }
      }
    } else if (permissionStatusStorage == PermissionStatus.denied ||
        permissionStatusManageExternalStorage == PermissionStatus.denied) {
      // Handle the case where permissions are denied
      final result = await [
        Permission.storage,
        Permission.manageExternalStorage,
      ].request();

      log("${result[PermissionStatus]}");
    }
  }

  Future<void> _onSaveStatus(
    SaveStatus event,
    Emitter<StatusProviderState> emit,
  ) async {
    GallerySaver.saveImage(state.images[event.currIdx].path);
  }

  
}

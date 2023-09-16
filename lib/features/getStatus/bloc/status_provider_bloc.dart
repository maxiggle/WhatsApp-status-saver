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
    on<GetImageStatus>(_onGetImageFromStatus);
    on<GetVideoStatus>(_onGetVideoFromStatus);
    on<SaveStatus>(_onSaveStatus);
  }

  Future<void> _onGetImageFromStatus(
    GetImageStatus event,
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
      log(images.toString());

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

  Future<void> _onGetVideoFromStatus(
    GetVideoStatus event,
    Emitter<StatusProviderState> emit,
  ) async {
    print('Entering _onGetVideoFromStatus');
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
      final videos = state.videos.toList();
      log(videos.toString());

      await for (final data in directory.list()) {
        print('Iterating over directory: ${data.path}');
        if (data.path.endsWith(event.ext)) {
          print('Found video: ${data.path}');

          videos.add(data);
          emit(state.copyWith(isLoading: false, videos: videos));
        }
      }
    } else if (permissionStatusStorage == PermissionStatus.denied &&
        permissionStatusManageExternalStorage == PermissionStatus.denied) {
      // Handle the case where permissions are denied
      await [
        Permission.storage,
        Permission.manageExternalStorage,
      ].request();
    }
  }

  Future<void> _onSaveStatus(
    SaveStatus event,
    Emitter<StatusProviderState> emit,
  ) async {
    GallerySaver.saveImage(state.images[event.currIdx].path);
  }
}

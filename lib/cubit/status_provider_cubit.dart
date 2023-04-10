// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_saver/get_file_path.dart';

part 'status_provider_state.dart';

class StatusProviderCubit extends Cubit<StatusProviderState> {
   List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];
  StatusProviderCubit() : super(const StatusProviderState());
 List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;
  void getStatus(String ext) async {
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.manageExternalStorage] == PermissionStatus.granted) {
      Directory? directory = Directory(AppConstant.WHATSAPP_PATH);
      if (directory.existsSync()) {
        final item = directory.listSync();
        for (var items in item) {
          if (ext == '.jpg') {
            getImages.add(items);
            emit(state.copyWith(imageVideoList: items));
          } else if (ext == '.mp4') {
            getVideos.add(items);
            emit(state.copyWith(imageVideoList: items));
          }
        }
      } else {
        log('Path not found');
      }
      emit(state.copyWith(dir: directory));
    }
  }
}

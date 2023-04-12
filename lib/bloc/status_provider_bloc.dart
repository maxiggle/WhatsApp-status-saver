import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_saver/get_file_path.dart';

part 'status_provider_event.dart';
part 'status_provider_state.dart';

class StatusProviderBloc
    extends Bloc<StatusProviderEvent, StatusProviderState> {
  StatusProviderBloc() : super(const StatusProviderState()) {
    on<GetStatus>(_onGetStatus);
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
}

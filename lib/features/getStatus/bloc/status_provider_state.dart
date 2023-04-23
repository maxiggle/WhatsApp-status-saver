part of 'status_provider_bloc.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

@immutable
class StatusProviderState extends Equatable {
  final dynamic dir;
  final FileSystemEntity? imageVideoList;

  final List<FileSystemEntity> images;
  final List<FileSystemEntity> videos;
  final bool isLoading;
  final bool isSaved;

  const StatusProviderState({
    this.dir,
    this.imageVideoList,
    this.images = const [],
    this.videos = const [],
    this.isLoading = false,
    this.isSaved = false,
  });

  @override
  List<Object?> get props => [dir, imageVideoList, images, videos, isLoading];

  StatusProviderState copyWith({
    dynamic dir,
    FileSystemEntity? imageVideoList,
    List<FileSystemEntity>? images,
    List<FileSystemEntity>? videos,
    bool? isLoading,
    bool? isSaved,
  }) {
    return StatusProviderState(
      dir: dir ?? this.dir,
      imageVideoList: imageVideoList ?? this.imageVideoList,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

///

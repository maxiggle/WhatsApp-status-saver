part of 'status_provider_bloc.dart';

@immutable
class StatusProviderState extends Equatable {
  final dynamic dir;
  final FileSystemEntity? imageVideoList;

  final List<FileSystemEntity> images;
  final List<FileSystemEntity> videos;

  const StatusProviderState({
    this.dir,
    this.imageVideoList,
    this.images = const [],
    this.videos = const [],
  });

  @override
  List<Object?> get props => [dir, imageVideoList, images, videos];

  StatusProviderState copyWith({
    dynamic dir,
    FileSystemEntity? imageVideoList,
    List<FileSystemEntity>? images,
    List<FileSystemEntity>? videos,
  }) {
    return StatusProviderState(
      dir: dir ?? this.dir,
      imageVideoList: imageVideoList ?? this.imageVideoList,
      images: images ?? this.images,
      videos: videos ?? this.videos,
    );
  }
}

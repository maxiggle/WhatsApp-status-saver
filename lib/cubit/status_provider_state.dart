// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'status_provider_cubit.dart';

class StatusProviderState extends Equatable {
  final dynamic dir;
  final  FileSystemEntity? imageVideoList;
  const StatusProviderState({this.dir,this.imageVideoList});
  @override
  List<Object?> get props => [dir,imageVideoList];

  StatusProviderState copyWith({
    dynamic dir,
    FileSystemEntity? imageVideoList,
  }) {
    return StatusProviderState(
      dir: dir ?? this.dir,
      imageVideoList: imageVideoList ?? this.imageVideoList,
    );
  }
}

part of 'status_provider_bloc.dart';

abstract class StatusProviderEvent extends Equatable {
  const StatusProviderEvent();

  @override
  List<Object> get props => [];
}

class GetImageStatus extends StatusProviderEvent {
  const GetImageStatus(this.ext);

  final String ext;

  @override
  List<Object> get props => [ext];
}

class GetVideoStatus extends StatusProviderEvent {
  final String ext;
  const GetVideoStatus(this.ext);
  @override
  List<Object> get props => [ext];
}

class SaveStatus extends StatusProviderEvent {
  const SaveStatus(this.currIdx);
  final int currIdx;
  @override
  List<Object> get props => [];
}

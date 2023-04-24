// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'save_image_to_device_cubit.dart';

class SaveImageToDeviceState extends Equatable {
 const SaveImageToDeviceState( {this.isSaved = false});
  final bool isSaved;
  @override
  List<Object> get props => [isSaved];

  

  SaveImageToDeviceState copyWith({
    bool? isSaved,
  }) {
    return SaveImageToDeviceState(
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

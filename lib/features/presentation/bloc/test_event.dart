part of 'test_bloc.dart';

@immutable
abstract class TestEvent extends Equatable{}

class UploadImageEvent extends TestEvent{

  final File? imageFile;

  UploadImageEvent({required this.imageFile});

  @override
  // TODO: implement props
  List<Object?> get props => [imageFile];

}

part of 'test_bloc.dart';

@immutable
abstract class TestState extends Equatable{}

class TestInitial extends TestState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageUploadSuccess extends TestState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageUploadLoading extends TestState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ImageUploading extends TestState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ImageUploadError extends TestState{

  final String message;

  ImageUploadError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];

}

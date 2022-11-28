import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../domain/usecases/upload_image_usecase.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {

  final UploadImage uploadImage;

  TestBloc({required this.uploadImage}) : super(TestInitial()) {
    on<TestEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UploadImageEvent>((event, emit) async=> await _uploadImage(event, emit));
  }

  Future<void> _uploadImage(UploadImageEvent event,Emitter<TestState> emit) async{
    emit(ImageUploadLoading());
    var imageFile=event.imageFile;
    final response=await uploadImage(Params(image: imageFile));
    emit(ImageUploading());
    await response.fold((failure) async=> emit(ImageUploadError(message: "Couldn't upload image")), (v) async=> emit(ImageUploadSuccess()));
  }
}

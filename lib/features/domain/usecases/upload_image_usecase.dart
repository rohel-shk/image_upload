import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_flutter/core/errors/failures.dart';
import 'package:image_flutter/core/usecases/usecase.dart';
import 'package:image_flutter/features/domain/repositories/image_upload_repository.dart';

class UploadImage implements UseCase<Void,Params>{

  final ImageUploadRepository imageUploadRepository;

  UploadImage({required this.imageUploadRepository});

  @override
  Future<Either<Failure, void>> call(Params params) async{
    return await imageUploadRepository.uploadImage(params.image);
  }
}

class Params{
  final File? image;

  Params({required this.image});
}
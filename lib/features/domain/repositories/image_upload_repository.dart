import 'package:dartz/dartz.dart';
import 'dart:io';
import 'package:image_flutter/core/errors/failures.dart';

abstract class ImageUploadRepository{
  Future<Either<Failure,void>> uploadImage(File? imageFile);
}
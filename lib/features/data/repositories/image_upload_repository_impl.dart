import 'dart:ffi';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_flutter/core/errors/exceptions.dart';
import 'package:image_flutter/core/errors/failures.dart';
import 'package:image_flutter/features/data/datasources/remote_datasource.dart';
import 'package:image_flutter/features/domain/repositories/image_upload_repository.dart';

class ImageUploadRepositoryImpl implements ImageUploadRepository{

  final RemoteDataSource remoteDataSource;

  ImageUploadRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> uploadImage(File? imageFile) async{
    try{
      await remoteDataSource.uploadImage(imageFile);
      return const Right(Void);
    }
    on ServerException{
      return Left(ServerFailure());
    }on ValidationException{
      return Left(ValidationFailure());
    }

  }
}
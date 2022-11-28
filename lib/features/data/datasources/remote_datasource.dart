import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_flutter/core/errors/exceptions.dart';

abstract class RemoteDataSource{
  Future<void> uploadImage(File? imageFile);
}

class RemoteDataSourceImpl implements RemoteDataSource{

  final Dio dio;

  RemoteDataSourceImpl({required this.dio});

  @override
  Future<void> uploadImage(File? imageFile) async{
    if (imageFile != null) {
      String filepath = imageFile.path;
      String filename = filepath.split('/').last;
      FormData data = FormData.fromMap({
        'key': '64667d2ed6f0078e4ba991acb2d7dabc',
        'image': await MultipartFile.fromFile(filepath, filename: filename),
        'name': 'abc'
      });
      var dio = Dio();
      var response=await dio.post("https://api.imgbb.com/1/upload",
          data: data, onSendProgress: (int sent, int total) {});
      if(response.statusCode!=200){
        throw ServerException();
      }
    }
    else{
      throw ValidationException();
    }
  }

}
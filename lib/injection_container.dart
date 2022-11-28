import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_flutter/features/data/datasources/remote_datasource.dart';
import 'package:image_flutter/features/data/repositories/image_upload_repository_impl.dart';
import 'package:image_flutter/features/domain/repositories/image_upload_repository.dart';
import 'package:image_flutter/features/domain/usecases/upload_image_usecase.dart';
import 'package:image_flutter/features/presentation/bloc/test_bloc.dart';

GetIt sl=GetIt.instance;

Future<void> init() async{
  sl.registerFactory<TestBloc>(() => TestBloc(uploadImage: sl()));

  sl.registerLazySingleton(() => UploadImage(imageUploadRepository: sl()));

  sl.registerLazySingleton<ImageUploadRepository>(() => ImageUploadRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(dio: sl()));

  sl.registerLazySingleton(() => Dio());
}
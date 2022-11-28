import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

abstract class UseCase<Type,Params>{
  Future<Either<Failure,void>> call(Params params);
}
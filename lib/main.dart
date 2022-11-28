import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_flutter/features/presentation/bloc/test_bloc.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

import 'home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>sl<TestBloc>(),
      child: MaterialApp(
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              elevation: 5
            )
          ),
          appBarTheme:const AppBarTheme(
            color: Colors.black,
            elevation: 0.0
          ),
          scaffoldBackgroundColor: Colors.white
        ),
        home:const HomeScreen(),
      ),
    );
  }
}
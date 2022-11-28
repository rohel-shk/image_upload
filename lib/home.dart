import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

import 'features/presentation/bloc/test_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image upload'),
      ),
      body: BlocConsumer<TestBloc, TestState>(
        listener: (context, state) {
          if (state is ImageUploadSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Image uploaded")));
          }
          if(state is ImageUploadError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) => Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: 150,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:[
                                  const Text('Upload',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        children:[ IconButton(
                                            onPressed: () {
                                              _getFromCamera();
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.camera,size: 40),),
                                          const SizedBox(height: 5),
                                          const Text('Camera')
                                        ]
                                      )),
                                  const SizedBox(width: 5),
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _getFromGallery();
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.photo_library,size: 40)),
                                        const SizedBox(height: 5),
                                        const Text('Photo library')
                                        ]
                                      )),
                                ],
                              ),
                              ]
                            ),
                          ));
                },
                child: SizedBox(
                  height: 200,
                    width: double.infinity,
                    child: imageFile == null
                        ? Image.asset('assets/upload_img.png',
                            fit: BoxFit.contain,color: Colors.white.withOpacity(0.5),colorBlendMode: BlendMode.modulate)
                        : Image.file(imageFile!, fit: BoxFit.contain)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<TestBloc>()
                        .add(UploadImageEvent(imageFile: imageFile));
                  },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)
                ),
                  child: state is ImageUploadLoading
                      ?
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                      children: const [
                        Text('Uploading image'),
                        SizedBox(width: 10),
                        SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                        )
                      : const Text('Upload Image'),

              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1800, maxWidth: 1800);
    if (xFile != null) {
      setState(() {
        imageFile = File(xFile.path);
      });
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (xFile != null) {
      setState(() {
        imageFile = File(xFile.path);
      });
    }
  }
}

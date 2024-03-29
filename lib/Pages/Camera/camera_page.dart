import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:form_validation/Utils/snackbar_utils.dart';
import 'package:form_validation/main.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  // late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  void startCamera(int direction) async {
    // final cameras = await availableCameras();
    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {}); // to refesh widget
    }).catchError((e) {
      print(e.toString());
      // Utils.showSnackBar(e.toString());
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    direction = direction == 0 ? 1 : 0;
                    startCamera(direction);
                  },
                );
              },
              child: button(
                  Icons.flip_camera_android_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () async {
                try {
                  final image = await cameraController.takePicture();
                  if (!mounted) return;

                  Navigator.pop(context, image.path);
                
                } catch (e) {
                  print(e);
                }
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

Widget button(IconData icon, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Container(
      margin: const EdgeInsets.only(
        left: 20,
        bottom: 20,
      ),
      height: 50,
      width: 50,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            )
          ]),
      child: Center(
        child: Icon(
          icon,
          color: Colors.black54,
        ),
      ),
    ),
  );
}

class DisplayImage extends StatelessWidget {
  final String imagePath;
  const DisplayImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}


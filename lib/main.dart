import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/form_provider.dart';
import 'Pages/register_page.dart';
import 'package:camera/camera.dart';
// import 'Utils/snackbar_utils.dart';

List<CameraDescription> cameras = <CameraDescription>[];
//better to make this a singleton than global variable

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.toString());
    // Utils.showSnackBar(e.toString());
  }
  
  runApp(ChangeNotifierProvider(
    create: (_) => FormProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RegisterWidget(),
    );
  }
}

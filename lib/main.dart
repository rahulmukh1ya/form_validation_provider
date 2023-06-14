import 'package:flutter/material.dart';
import 'package:form_validation/Pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  }
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final isLoggedIn = (prefs.getBool('isLoggedIn') == null)
      ? false
      : prefs.getBool('isLoggedIn');
  runApp(ChangeNotifierProvider(
    create: (_) => FormProvider(),
    child: MyApp(
      isLoggedIn: isLoggedIn!,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, this.isLoggedIn = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isLoggedIn ? const HomePage() : const RegisterWidget(),
    );
  }
}

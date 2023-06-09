import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/form_provider.dart';
import 'Pages/register_page.dart';

void main() {
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


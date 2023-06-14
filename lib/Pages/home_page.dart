import 'package:flutter/material.dart';
import 'package:form_validation/Pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  String userEmail = '';
  String userPhone = '';
  String userAddress = '';
  String userZipCode = '';
  String userSecPhone = '';
  String userImage = '';

  void getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      userName = prefs.getString("userName")!;
      userEmail = prefs.getString("userEmail")!;
      userPhone = prefs.getInt("userPhone").toString();
      userAddress = prefs.getString("userAddress")!;
      userZipCode = prefs.getInt("userZipCode").toString();
      userSecPhone = prefs.getInt("userSecPhone").toString();
      userImage = prefs.getString("userImage")!;
    });
  }

  void deleteUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userName");
    prefs.remove("userEmail");
    prefs.remove("userPhone");
    prefs.remove("userAddress");
    prefs.remove("userZipCode");
    prefs.remove("userSecPhone");
    prefs.remove("userPassword");
    prefs.remove("userImage");
    prefs.remove("isLoggedIn");
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          automaticallyImplyLeading: false,
          // Also consider Navigator.pushReplacementNamed(context, route);
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
                image: DecorationImage(
                    image: FileImage(
                      File(userImage),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Username: '),
                Text(userName),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Email: '),
                Text(userEmail),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Phone Number'),
                Text(userPhone),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Address: '),
                Text(userAddress),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Zip Code: '),
                Text(userZipCode),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text('Secondary Phone: '),
                Text(userSecPhone),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                deleteUserData();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterWidget(),
                  ),
                );
              },
              child: const Text('Logout', style: TextStyle(fontSize: 20)),
            )
          ],
        ));
  }
}

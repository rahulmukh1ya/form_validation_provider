import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("userName")!;
      userEmail = prefs.getString("userEmail")!;
      userPhone = prefs.getInt("userPhone").toString();
      userAddress = prefs.getString("userAddress")!;
      userZipCode = prefs.getInt("userZipCode").toString();
      userSecPhone = prefs.getInt("userSecPhone").toString();
    });
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
        ),
        body: Column(
          children: <Widget>[
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
          ],
        ));
  }
}

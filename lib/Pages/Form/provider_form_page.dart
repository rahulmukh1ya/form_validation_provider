import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:form_validation/Provider/form_provider.dart';
import 'custom_form_field.dart';
import '../home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderFormPage extends StatefulWidget {
  const ProviderFormPage({super.key});

  @override
  State<ProviderFormPage> createState() => _ProviderFormPageState();
}

class _ProviderFormPageState extends State<ProviderFormPage> {
  final _formKey = GlobalKey<FormState>();
  late FormProvider _formProvider;

  void saveUserData({
    required String userName,
    required String userEmail,
    required int userPhone,
    required String userPassword,
    required String userAddress,
    required int userZipCode,
    int userSecPhone = 0000000000,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", userName);
    await prefs.setString("userEmail", userEmail);
    await prefs.setInt("userPhone", userPhone);
    await prefs.setString("userPassword", userPassword);
    await prefs.setString("userAddress", userAddress);
    await prefs.setInt("userZipCode", userZipCode);
    await prefs.setInt("userSecPhone", userSecPhone);
    await prefs.setBool("isLoggedIn", true);
  }

  @override
  Widget build(BuildContext context) {
    _formProvider = Provider.of<FormProvider>(context);
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomFormField(
              labelText: 'Name',
              hintText: 'Your Name, e.g: John Doe',
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[a-zA-Z]+|\s"),
                )
              ],
              onChanged: _formProvider.validateName,
              errorText: _formProvider.name.error,
            ),
            CustomFormField(
              labelText: 'Email',
              hintText: 'Your email, e.g: johndoe@gmail.com',
              onChanged: _formProvider.validateEmail,
              errorText: _formProvider.email.error,
            ),
            CustomFormField(
              labelText: 'Phone',
              hintText: 'Your phone number, e.g: 98xxxxxxxx',
              onChanged: _formProvider.validatePhone,
              errorText: _formProvider.phone.error,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
            ),
            CustomFormField(
              labelText: 'Password',
              hintText: 'Enter your password',
              obscureText: true,
              onChanged: _formProvider.validatePassword,
              errorText: _formProvider.password.error,
            ),
            CustomFormField(
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
              obscureText: true,
              onChanged: _formProvider.validateRePassword,
              errorText: _formProvider.repassword.error,
            ),
            CustomFormField(
              labelText: 'Address',
              hintText: 'Enter your address',
              onChanged: _formProvider.validateAddress,
              errorText: _formProvider.address.error,
            ),
            CustomFormField(
              labelText: 'Zip Code',
              hintText: 'Enter your Zip Code',
              onChanged: _formProvider.validateZipCode,
              errorText: _formProvider.zipCode.error,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
            ),
            CustomFormField(
              labelText: 'Second Phone Number',
              hintText: 'Enter your second phone number (Optional)',
              onChanged: _formProvider.validateSecPhone,
              errorText: _formProvider.secPhone.error,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
            ),
            Consumer<FormProvider>(
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {
                      if (model.validate) {
                        saveUserData(
                          userName: model.name.value!,
                          userEmail: model.email.value!,
                          userPhone: int.parse(model.phone.value!),
                          userPassword: model.password.value!,
                          userAddress: model.address.value!,
                          userZipCode: int.parse(model.zipCode.value!),
                          userSecPhone:
                              int.parse(model.secPhone.value ?? "0000000000"),
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.yellow[800],
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}

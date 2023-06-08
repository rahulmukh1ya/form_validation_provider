import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:form_validation/form_provider.dart';
import 'custom_form_field.dart';
import 'home_page.dart';

class ProviderFormPage extends StatefulWidget {
  const ProviderFormPage({super.key});

  @override
  State<ProviderFormPage> createState() => _ProviderFormPageState();
}

class _ProviderFormPageState extends State<ProviderFormPage> {
  final _formKey = GlobalKey<FormState>();
  late FormProvider _formProvider;

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
              onChanged: _formProvider.validatePassword,
              errorText: _formProvider.password.error,
            ),
            CustomFormField(
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
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
                return ElevatedButton(
                  onPressed: () {
                    if (model.validate) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ));
                    }
                  },
                  child: const Text('Submit'),
                );
              },
            )
          ],
        ));
  }
}

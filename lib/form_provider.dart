import 'package:flutter/material.dart';
import 'package:form_validation/validation_model.dart';
import 'regex_extension.dart';

class FormProvider extends ChangeNotifier {
  //name, email, password, re-password, phone no, address
  //zip code, secondary phone no., profile image

  ValidationModel _name = ValidationModel(null, null);
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);
  ValidationModel _rePassword = ValidationModel(null, null);
  ValidationModel _phone = ValidationModel(null, null);
  ValidationModel _address = ValidationModel(null, null);
  ValidationModel _zipCode = ValidationModel(null, null);
  ValidationModel _secPhone = ValidationModel(null, null);

  ValidationModel get name => _name;
  ValidationModel get email => _email;
  ValidationModel get password => _password;
  ValidationModel get repassword => _rePassword;
  ValidationModel get phone => _phone;
  ValidationModel get address => _address;
  ValidationModel get zipCode => _zipCode;
  ValidationModel get secPhone => _secPhone;

  void validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      _email = ValidationModel(val, null);
    } else {
      _email = ValidationModel(null, 'Please enter a valid email');
    }
    notifyListeners();
  }

  void validatePassword(String? val) {
    if (val != null && val.isValidPassword) {
      _password = ValidationModel(val, null);
    } else {
      _password = ValidationModel(null,
          'Password must be atleast 6 characters long');
    }
    notifyListeners();
  }

  void validateRePassword(String? val) {
    if (val != null && val == password.value) {
      _rePassword = ValidationModel(val, null);
    } else {
      _rePassword = ValidationModel(null, 'Password does not match');
    }
    //NEEDS CORRECTION
    notifyListeners();
  }

  void validateName(String? val) {
    if (val != null && val.isValidName) {
      _name = ValidationModel(val, null);
    } else {
      _name = ValidationModel(null, 'Please enter a valid name');
    }
    notifyListeners();
  }

  void validatePhone(String? val) {
    if (val != null && val.isValidPhone) {
      _phone = ValidationModel(val, null);
    } else {
      _phone = ValidationModel(null, 'Phone number consist of 10 digits');
    }
    notifyListeners();
  }

  void validateSecPhone(String? val) {
    if (val != null && val.isValidPhone) {
      _secPhone = ValidationModel(val, null);
    } else {
      _secPhone = ValidationModel(null, 'Phone number consist of 10 digits');
    }
    notifyListeners();
  }

  void validateAddress(String? val) {
    if (val != null && val != '') {
      _address = ValidationModel(val, null);
    } else {
      _phone = ValidationModel(null, 'Address cannot be empty');
    }
    notifyListeners();
  }

  void validateZipCode(String? val) {
    if (val != null && val.isValidZipCode) {
      _zipCode = ValidationModel(val, null);
    } else {
      _zipCode = ValidationModel(null, 'Zip code must consist of 5 digtis');
    }
    notifyListeners();
  }

  bool get validate {
    return _email.value != null &&
        _password.value != null &&
        _password.value == _rePassword.value &&
        _phone.value != null &&
        _zipCode.value !=null &&
        _address.value != null &&
        _name.value != null;
  }
}

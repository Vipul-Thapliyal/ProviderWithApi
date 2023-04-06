import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_tech_brothers/model/user_model.dart';
import 'package:mvvm_tech_brothers/repository/auth_repository.dart';
import 'package:mvvm_tech_brothers/utils/routes/routes_name.dart';
import 'package:mvvm_tech_brothers/utils/utils.dart';
import 'package:mvvm_tech_brothers/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  // Loading for login
  bool _loading = false;
  bool get  loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Loading for SignUp
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  //Login User
  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.flushBarErrorMessages("Login Successfull", context);
      Navigator.pushNamed(context, RoutesName.home);
      print(value.toString());

    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessages(error.toString(), context);
      print(error.toString());
    });
  }

  //Sign Up User
  Future<void> signUpApi(dynamic data,BuildContext context) async {
    setSignUpLoading(true);

    _myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);

      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(
        UserModel(
          token: value["token"].toString()
        )
      );

      Utils.flushBarErrorMessages("SignUp Successfull", context);
      Navigator.pushNamed(context, RoutesName.home);
      print(value.toString());

    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessages(error.toString(), context);
      print(error.toString());
    });
  }

}
import 'package:flutter/material.dart';
import 'package:mvvm_tech_brothers/res/components/round_button.dart';
import 'package:mvvm_tech_brothers/utils/routes/routes_name.dart';
import 'package:mvvm_tech_brothers/utils/utils.dart';
import 'package:mvvm_tech_brothers/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  // For storing values in the controllers which are typed in the textformfields
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //For changing focus to nextfield on tap of done button
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  //Disposing all fields and nodes to free up space from RAM
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              //Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                    hintText: "Email",
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.alternate_email)
                ),
                onFieldSubmitted: (value) {
                  // FocusScope.of(context).requestFocus(passwordFocusNode);
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),

              //Password Field
              ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    focusNode: passwordFocusNode,
                    controller: _passwordController,
                    obscureText: _obsecurePassword.value,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      hintText: "Password",
                      label: Text("Password"),
                      prefixIcon: Icon(Icons.lock_open_outlined),
                      suffixIcon: InkWell(
                        onTap: () {
                          _obsecurePassword.value = !_obsecurePassword.value;
                        },
                        child: Icon(
                            _obsecurePassword.value ? Icons.visibility_off_outlined : Icons.visibility
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: height * .085,), // For Separation

              //Button to SignUp
              RoundButton(
                title: "Sign Up",
                loading: authViewModel.signUpLoading,
                onPress: () {
                  if(_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessages("Please enter email", context);
                  } else if(_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessages("Please enter password", context);
                  } else if(_passwordController.text.length < 6) {
                    Utils.flushBarErrorMessages("Please enter 6 digit password", context);
                  } else {
                    final headers = {'Content-Type': 'application/json'};

                    Map data  = {
                      "email" : _emailController.text.toString(),
                      "password" : _passwordController.text.toString(),
                    };

                    authViewModel.signUpApi(data, context);
                    print("Api Hit");
                  }
                },
              ),

              SizedBox(height: height * .02,), // For Separation

              //Button To Tap if user already have an account
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.login); // Go To Login Screen
                },
                child: Text("Already have an account? Login")
              )

            ],
          ),
        )
    );
  }
}

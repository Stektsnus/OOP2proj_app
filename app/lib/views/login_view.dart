import 'package:app/views/home_view.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import "create_user_view.dart" as create_user_view;
import "../helpers/globals.dart" as globals;
import "../models/user_model.dart" as user_model;
import "../main.dart" as main;

String dataBaseUrl = "http://10.0.2.2:3000/";

class LoginView extends StatefulWidget {
  final globals.LoginCallback loginCallback;
  const LoginView({required this.loginCallback, Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginFormGlobalKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  void validateLogin() {
    bool? validation = _loginFormGlobalKey.currentState?.validate();
    print(validation);
    if (_loginFormGlobalKey.currentState?.validate() == false) {
      print("Login validation failed");
      _loginFormGlobalKey.currentState?.save();
    }
    else {
      sendLoginRequest()
      .then((value) {
        print(value);
        if (value == 200) {
          widget.loginCallback(_userNameController.text);
        } else {
          showLoginFailureMessage(context);
        }
      })
      .catchError((error) {
        print("error in login caught");
        print(error);
        throw error;
      });
    }
  }

  Future<int> sendLoginRequest() async {
    var url = Uri.parse(dataBaseUrl + "api/users/login");

    Map body = {
        "username" : _userNameController.text,
        "password" : _passwordController.text,
    };
    String data = json.encode(body);
    var response = await http.post(
      url,
      body: data,
      headers: {
        "Content-Type" : "application/json"
      },
    );
    return response.statusCode;
  }

  void showLoginSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text("Success!"),
            content: Text("Logged in."),
      )
    );
  }

  void showLoginFailureMessage(BuildContext context ) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text("Sorry"),
            content: Text("Username or password is wrong. Try again."),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            "Login",
            style: TextStyle(
                color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
      ),
      body: Form(
        key: _loginFormGlobalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter username",
                ),
                validator: (value) {
                  print("username validator called");
                  if (value == null || value == "") {
                    return "Please enter a username";
                  }
                  if (value.split("").contains(" ")) {
                    return "Please enter a valid username";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter password",
                ),
                validator: (value) {
                  print("username validator called");
                  if (value == null || value == "") {
                    return "Please enter a password";
                  }
                  if (value.split("").contains(" ")) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text("Create new user", style: TextStyle(fontSize: 14, color: Colors.grey)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const create_user_view.CreateUserView())
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: validateLogin,
                  child: const Text("Login", style: TextStyle(fontSize: 14)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
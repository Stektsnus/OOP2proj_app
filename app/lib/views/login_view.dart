import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class LoginView extends StatelessWidget {
  const LoginView({ Key? key }) : super(key: key);

   

  void validateLogin() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter username",
            ),
            validator: (value) {
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
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter password",
            ),
            validator: (value) {
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
              onPressed: validateLogin,
              child: const Text("Create new user", style: TextStyle(fontSize: 14, color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: validateLogin,
              child: const Text("Login", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ],
    );
  }
}
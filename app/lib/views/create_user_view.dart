import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String dataBaseUrl = "http://10.0.2.2:3000/";

class CreateUserView extends StatefulWidget {
  const CreateUserView({ Key? key }) : super(key: key);

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  bool hideFirstPassword = true;
  bool hideSecondPassword = true;

  final _createUserFormGlobalKey = GlobalKey<FormState>();

  // Controllers for the form
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstPasswordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();

  void validateSubmission(BuildContext context) async {
    // Hämta http-data
    print("Validatesubmission called");
    var url = Uri.parse(dataBaseUrl + "api/users/signup");
    Map data = {
          "username" : userNameController.text,
          "password" : firstPasswordController.text,
    };
    String body = json.encode(data);
    await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body
        
    ).then((res) {
      if (res.statusCode == 409) {
        showFailureMessage(context);
        print('Response status: ${res.statusCode}');
        print('Response body: ${res.body}');
        // Navigate to the real app view here
      } else {
        showSuccessMessage(context);
        Navigator.pop(context);
      }
    });
  }

  void toggleFirstPasswordVisibility(){
    setState(() {
      if (hideFirstPassword == false) {
        hideFirstPassword = true;
      }
      else {
        hideFirstPassword = false;
      }
    });
  }

  void toggleSecondPasswordVisibility(){
    setState(() {
      if (hideSecondPassword == false) {
      hideSecondPassword = true;
      }
      else {
        hideSecondPassword = false;
      }
    });
  }

  void showSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text("Success!"),
            content: Text("Your account has been created."),
      )
    );
  }

  void showFailureMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
            title: Text("Sorry"),
            content: Text("An account with this name already exists. Try another one."),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _createUserFormGlobalKey,
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "Create new user",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter user name",
                  ),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Username cannot be empty";
                    } else if (value.split("").contains(" ")){
                      return "Username contains spaces";
                    }
                    return null;
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: firstPasswordController,
                  obscureText: hideFirstPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Enter password",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: toggleFirstPasswordVisibility,
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.length < 12 || value.split("").contains(" ")){
                      return "Please enter a valid password";
                    }
                    if (value != secondPasswordController.text) {
                      return "Both passwords must be the same";
                    }
                    return null;
                  },
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: secondPasswordController,
                  obscureText: hideSecondPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Enter password again",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: toggleSecondPasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 12 || value.split("").contains(" ")){
                      return "Please enter a valid password";
                    }
                    if (value != firstPasswordController.text) {
                      return "Both passwords must be the same";
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_createUserFormGlobalKey.currentState != null) {
                        if (_createUserFormGlobalKey.currentState!.validate()){
                          validateSubmission(context);
                        } else {
                          _createUserFormGlobalKey.currentState?.save();
                        }
                      }
                    },
                    child: const Text("Submit", style: TextStyle(fontSize: 16)),
                  )
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }
}

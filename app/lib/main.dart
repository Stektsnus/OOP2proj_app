import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import "dart:convert";

String dataBaseUrl = "http://10.0.2.2:3000/";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainView(),
      theme: ThemeData.dark(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool loggednIn = false;
  int _selectedIndex = 0;
  static const TextStyle _optionStyle = 
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _bodyOptions = <Widget>[
    
    const Text(
      "Index 1: xD",
      style: _optionStyle,
    ),
    const Text(
      "Index 2: Settingsview", // Lägg in nya widgets här för respektive vy ex scaffold med body
      style: _optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            "Nöd",
            style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),
      ),
      body: const Center(
        child: CreateUserView()                         //_bodyOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        iconSize: 30,
        onTap: _onItemTapped,
        backgroundColor: Colors.black54,
      ), // TIPS: KLICKA CTRL + SPACE FÖR ALTERNATIV I WIDGETS
    );
  }
}

// NYI: Skapa ny vy för skapandet av en användare


class LoginView extends StatelessWidget {
  const LoginView({ Key? key }) : super(key: key);

  void validateLogin() {
    print("User validation success");
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
              labelText: "Enter user name",
            ),
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
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: validateLogin,
              child: const Text("Create new user", style: TextStyle(fontSize: 14, color: Colors.grey)),
            ),
            TextButton(
              onPressed: validateLogin,
              child: const Text("Login", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ],
    );
  }
}

class CreateUserView extends StatefulWidget {
  const CreateUserView({ Key? key }) : super(key: key);

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  bool hideFirstPassword = true;
  bool hideSecondPassword = true;

  final formGlobalKey = GlobalKey<FormState>();


  // Controllers for the form
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstPasswordController = TextEditingController();
  TextEditingController secondPasswordController = TextEditingController();

  void validateSubmission() async {
    // Hämta http-data
    print("Validatesubmission called");
    var url = Uri.parse(dataBaseUrl + "api/users/signup");
    Map data = {
          "username" : userNameController.text,
          "password" : firstPasswordController.text,
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body
        
    ).then((res) {
      if (res.statusCode == 200) {
        print('Response status: ${res.statusCode}');
        print('Response body: ${res.body}');
        // Navigate to the real app view here
      }
      // Display error message

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Create new user",
                style: TextStyle(
                  fontSize: 30,
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
                  print("validator called");
                  if (value == null || value == "") {
                    return "Username cannot be empty.";
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
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (formGlobalKey.currentState != null) {
                      if (formGlobalKey.currentState!.validate()){
                        validateSubmission();
                      } else {
                        formGlobalKey.currentState?.save();
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
    );
  }
}
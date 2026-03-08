import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/roundedButton.dart';
import 'package:lexiquest/Componenets/whitetextinput.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';
import 'package:lexiquest/Data/Repositories/Firebase/authrepository.dart';
import 'package:lexiquest/Features/Auth/ViewModels/authviewmodel.dart';
import 'package:provider/provider.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final authVM = Provider.of<Authviewmodel>(context);

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFAEB1F4), // purple (middle)

              Color(0xFFF3BFEB), // light pink (top)
              Color.fromARGB(255, 186, 189, 250), Color(0xFFAEB1F4),
              Color(0xFFF1D5ED), // light pink (bottom)
            ],
            stops: [0.0, 0.3, 0.5, 0.6, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LexiQuest',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Golos',
                  color: Colors.white,
                ),
              ),

              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Golos',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Step into a world where learning meets adventure',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Golos',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Whitetextinput(
                      iconimage: Icons.person,
                      textinputtext: "Username",
                      textcontroller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username cant be null";
                        } else if (value.length < 5) {
                          return "Username must be more then 5 letters";
                        } else if (value.length >= 10) {
                          return "Username cant be more then 10 letters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    Whitetextinput(
                      iconimage: Icons.email,
                      textinputtext: "Email",
                      textcontroller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email cant be null";
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    Whitetextinput(
                      iconimage: Icons.lock,
                      textinputtext: "Password",
                      textcontroller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cant be null";
                        } else if (value.length < 5) {
                          return "Password must be more then 5 letters";
                        } else if (value.length >= 15) {
                          return "Password cant be more then 15 letters";
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Roundedbutton(
                isFilled: true,
                text: authVM.isLoading ? 'Loading' : 'Sign Up',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = await authVM.signUp(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      usernameController.text.trim(),
                    );
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Sign up failed. Try again.")),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 20),

              Roundedbutton(
                isFilled: false,
                text: 'Login ',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

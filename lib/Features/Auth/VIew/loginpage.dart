import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/roundedButton.dart';
import 'package:lexiquest/Componenets/whitetextinput.dart';
import 'package:lexiquest/Features/Auth/ViewModels/authviewmodel.dart';
import 'package:lexiquest/Features/Account/Viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final authVM = Provider.of<Authviewmodel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('Testing auto-login...');

      final user = await authVM.autoLogin();
      print('Auto-login user: $user');

      if (user != null) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3BFEB), // light pink (top)
              Color(0xFFAEB1F4), // purple (middle)
              Color(0xFFAEB1F4),
              Color(0xFFAEB1F4),
              Color(0xFFF1D5ED), // light pink (bottom)
            ],
            stops: [0.0, 0.4, 0.5, 0.6, 1.0],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80), // spacing from top
                  const Text(
                    'LexiQuest',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Golos',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Log into your \nAccount',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Golos',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Step into a world where learning meets adventure',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Golos',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form Fields
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Whitetextinput(
                          iconimage: Icons.email,
                          textinputtext: "Email",
                          textcontroller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Whitetextinput(
                          iconimage: Icons.lock,
                          textinputtext: "Password",
                          textcontroller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        // Login Button
                        Roundedbutton(
                          isFilled: true,
                          text: authVM.isLoading ? "Logging in..." : "Login",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final user = await authVM.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );

                              bool success = user != null;

                              if (success) {
                                await Provider.of<Userviewmodel>(
                                  context,
                                  listen: false,
                                ).fetchUser(user.uid);
                                Navigator.pushReplacementNamed(
                                  context,
                                  "/home",
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Login failed. Check credentials.",
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 15),

                        // Sign-up Button
                        Roundedbutton(
                          isFilled: false,
                          text: 'Sign Up',
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/signup");
                          },
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

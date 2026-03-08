import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lexiquest/Componenets/gradientButton.dart';
import 'package:lexiquest/Componenets/plaintextinput.dart';
import 'package:lexiquest/Componenets/togglefillbutton.dart';
import 'package:lexiquest/Features/Account/Domain/profilepicassets.dart';
import 'package:lexiquest/Features/Account/View/imagepickerscreen.dart';
import 'package:lexiquest/Features/Account/Viewmodel/userviewmodel.dart';
import 'package:lexiquest/Features/Account/View/accountpage.dart';
import 'package:lexiquest/Features/Home/View/homenavigation.dart';
import 'package:provider/provider.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  int selectedImageId = 0; 

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userviewmodel>(context);
    int imageIdToUse = selectedImageId != 0
        ? selectedImageId
        : userProvider.user?.profilepicture ?? 7;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Column(
                        children: const [
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              color: Color(0xFF414141),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff9397E8),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Homenavigation(),
                              ),
                              (route) => false, // removes all previous routes
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Picture
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: const Color.fromARGB(255, 95, 58, 58),
                    backgroundImage: NetworkImage(
                      Profilepicassets.getImage(imageIdToUse),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Imagepickerscreen(
                              onImageSelected: (id) {
                                setState(() {
                                  selectedImageId = id;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8588DE),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Basic Details Form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Basic Details',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Color(0xFF757575),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Plaintextinput(
                      iconimage: Icons.person,
                      textinputtext: "Username",
                      textcontroller: usernameController,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username cant be null";
                        } else if (value.length < 5) {
                          return "Username must be more than 5 letters";
                        } else if (value.length >= 10) {
                          return "Username cant be more than 10 letters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Plaintextinput(
                      iconimage: Icons.email,
                      textinputtext: "Email",
                      textcontroller: emailController,
                      obscureText: false,
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
                    const SizedBox(height: 10),
                    Plaintextinput(
                      iconimage: Icons.lock,
                      textinputtext: "Password",
                      textcontroller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cant be null";
                        } else if (value.length < 5) {
                          return "Password must be more than 5 letters";
                        } else if (value.length >= 15) {
                          return "Password cant be more than 15 letters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'App theme',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Color(0xFF757575),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        ToggleFillButton(
                          text: "Dark mode",
                          color: const Color(0xFF8588DE),
                          onChanged: (active) {
                            print("Button state: $active");
                          },
                        ),
                        const SizedBox(width: 10),
                        ToggleFillButton(
                          text: "Light mode",
                          color: const Color(0xFF8588DE),
                          onChanged: (active) {
                            print("Button state: $active");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Save / Cancel Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 10),
            child: Column(
              children: [
                GradientButton(
                  buttonText: "Save changes",
                  actionFunction: () {
                    userProvider.updateUserProfile(
                      username: usernameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      imageId: selectedImageId,
                    );
                    // Also update other fields if needed
                  },
                  gradientColors: const [Color(0xFF767BDE), Color(0xFFBEC1FE)],
                  buttonHeight: 50,
                ),
                const SizedBox(height: 10),
                GradientButton(
                  actionFunction: () {
                    Navigator.pop(context);
                  },
                  buttonHeight: 50,
                  buttonText: "Cancel",
                  borderOnly: true,
                  borderColor: const Color(0xFF8E92F6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

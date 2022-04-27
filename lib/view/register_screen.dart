import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_1/api_services/servicess.dart';
import 'package:task_1/constant.dart';
import 'package:task_1/view/textpage.dart';

import 'bottombar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    var pickFile = await picker.getImage(source: ImageSource.gallery);

    if (pickFile != null) {
      setState(() {
        _image = File(pickFile.path);
      });
    }
  }

  Future<String?> uploadFile(File file, String filename) async {
    print("File path:${file.path}");
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref("user_image/$filename")
          .putFile(file);
      return response.storage.ref("user_image/$filename").getDownloadURL();
    } on firebase_storage.FirebaseException catch (e) {
      print(e);
    }
  }

  addUserData() async {
    String? userImage =
        await uploadFile(_image!, "${kfirebase.currentUser!.email}");
    FirebaseFirestore.instance
        .collection("user")
        .doc(kfirebase.currentUser!.uid)
        .set({
      "fname": _fname.text,
      "lname": _lname.text,
      "email": _email.text,
      "city": selectCity,
      "number": _number.text,
      "password": _password.text,
      'gender': _selectedGender,
      "avatar": userImage
    }).catchError((e) {
      print("ERROR==>>$e");
    }).then((value) => Get.to(BottomBar()));
  }

  List<String> city = ['Surat', 'Ahmedabad', 'Vadodara'];
  dynamic selectCity = 'Surat';

  String _selectedGender = 'male';
  String _selectedGender1 = 'Singing';

  final _formkey = GlobalKey<FormState>();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _email = TextEditingController();
  final _number = TextEditingController();
  final _city = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.080),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        height: Get.height * 0.18,
                        width: Get.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 5)
                          ],
                          border: Border.all(color: Colors.white, width: 10),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: _image == null
                            ? Icon(Icons.camera_alt)
                            : Image.file(_image!),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.030),
                    Texts(
                      size: 17,
                      text: "Set Up Your Profile",
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: Get.height * 0.010),
                    Texts(
                      size: 14,
                      text: "Update Your Profile to Connect Your Doctor With",
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    Texts(
                      size: 14,
                      text: "better impression",
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: Get.height * 0.030),
                    Texts(
                      size: 18,
                      text: "Registration",
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: Get.height * 0.020),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextFormField(
                              controller: _fname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter First name";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "First Name",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: TextFormField(
                              controller: _lname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter last name";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Last Name",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: Get.height * 0.010),
                    TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.010),
                    TextFormField(
                      controller: _number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter the number";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Mobile Number",
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.010),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Gender',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              value: 'male',
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                            Text('Male'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              value: 'Female',
                              groupValue: _selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                            Text('Female'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.010),
                    TextFormField(
                      controller: _city,
                      decoration: InputDecoration(
                        hintText: "City",
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: selectCity,
                              onChanged: (value) {
                                setState(
                                  () {
                                    selectCity = value;
                                  },
                                );
                              },
                              items: city
                                  .map((e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.010),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Hobbies',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              value: 'Singing',
                              groupValue: _selectedGender1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender1 = value!;
                                });
                              },
                            ),
                            Text('Singing'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<String>(
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              value: 'Dancing',
                              groupValue: _selectedGender1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender1 = value!;
                                });
                              },
                            ),
                            Text('Dancing'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.010),
                    TextFormField(
                      controller: _password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter the password";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "password",
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.010),
                    GestureDetector(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          bool status = await FireBaseAuthService.getData(
                              email: _email.text, password: _password.text);
                          if (status == true) {
                            addUserData();
                          }
                        }
                      },
                      child: Container(
                        height: Get.height * 0.070,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blueAccent),
                        child: Center(
                            child: Texts(
                          size: 16,
                          text: "Submit",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

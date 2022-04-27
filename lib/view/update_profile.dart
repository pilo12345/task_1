import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_1/view/textpage.dart';

import '../constant.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
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

  /// Show Image

  /// Adding Data to FireBase
  // Future updateUserData() async {
  //   String? imageUrl = await uploadFile(image!, "${Random().nextInt(1000)}");
  //
  //   bool status = await FireBaseService.signUpService(
  //     email: _email!.text,
  //     password: _password!.text,
  //   );
  //   SharedPreferences userData = await SharedPreferences.getInstance();
  //
  //   if (status == true) {
  //     userData.setString('email', _email!.text);
  //     firebaseFirestore
  //         .collection('User')
  //         .doc(firebaseAuth.currentUser!.uid)
  //         .update(
  //       {
  //         'firstName': _firstName!.text,
  //         'lastName': _lastName!.text,
  //         'mobileNumber': _mobileNum!.text,
  //         'passWord': _password!.text,
  //         'emailId': _email!.text,
  //         'image': imageUrl,
  //         'gender': genderController.genderSelect.value == 0 ? 'Men' : 'Female',
  //         'city': selectCity,
  //         'hobbies': hobbiesController.hobbiesSelect.value &&
  //                 hobbiesController.hobbiesSelect1.value == true
  //             ? 'Singing' 'Dancing'
  //             : hobbiesController.hobbiesSelect1.value
  //                 ? 'Dancing'
  //                 : hobbiesController.hobbiesSelect1.value
  //                     ? 'Singing'
  //                     : 'Not interested',
  //       },
  //     ).whenComplete(
  //       () => Get.off(
  //         () => HomeScreen(),
  //       ),
  //     );
  //   }
  // }
  File? _image;
  final picker = ImagePicker();

  Future setImage() async {
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

  String? userImage;

  void getUserData() async {
    final user = await firestore
        .collection("user")
        .doc(kfirebase.currentUser!.uid)
        .get();
    Map<String, dynamic>? getUserData = user.data();
    _email.text = getUserData!['email'];
    _fname.text = getUserData['fname'];
    _lname.text = getUserData['lname'];
    _number.text = getUserData['number'];
    userImage = getUserData['avatar'];
    _city.text = getUserData['city'];
    // setState(() {
    //   _character = getUserData['gender'] == 'Female'
    //       ? SingingCharacter.female
    //       : SingingCharacter.male;
    // });
  }

  updateUserData() async {
    String? userImage =
        await uploadFile(_image!, "${kfirebase.currentUser!.email}");
    FirebaseFirestore.instance
        .collection("user")
        .doc(kfirebase.currentUser!.uid)
        .update({
      "fname": _fname.text,
      "lname": _lname.text,
      "email": _email.text,
      "city": selectCity,
      "number": _number.text,
      'gender': _selectedGender,
      "avatar": userImage
    }).catchError((e) {
      print("ERROR==>>$e");
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.35,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    title: Texts(
                      size: 16,
                      text: "Profile",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    trailing: Texts(
                      size: 16,
                      text: "LogOut",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.030,
                  ),
                  GestureDetector(
                    onTap: () {
                      setImage();
                    },
                    child: Container(
                      height: Get.height * 0.2,
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
                          ? Image.network(userImage!)
                          : Image.file(_image!),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.020),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  fillColor:
                                      MaterialStateProperty.all(Colors.blue),
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
                                  fillColor:
                                      MaterialStateProperty.all(Colors.blue),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  fillColor:
                                      MaterialStateProperty.all(Colors.blue),
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
                                  fillColor:
                                      MaterialStateProperty.all(Colors.blue),
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
                        GestureDetector(
                          onTap: () {
                            updateUserData();
                          },
                          child: Container(
                            height: Get.height * 0.070,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.blueAccent),
                            child: Center(
                              child: Texts(
                                size: 16,
                                text: "Update Profile",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

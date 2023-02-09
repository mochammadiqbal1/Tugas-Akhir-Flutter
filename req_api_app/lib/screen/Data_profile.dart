import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:req_api_app/constant/color.dart';
import 'package:req_api_app/constant/profile.dart';

final _formkey = GlobalKey<FormState>();

class DataProfile extends StatefulWidget {
  DataProfile({super.key});

  @override
  State<DataProfile> createState() => _DataProfileState();
}

class _DataProfileState extends State<DataProfile> {
  final _auth = FirebaseAuth.instance;

  final userController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tProfile,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize - 10),
          child: Column(
            children: <Widget>[
              FutureBuilder<DocumentSnapshot>(
                future: users.doc(user!.uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                    String userName = "${data['userName']}";
                    String email = "${data['email']}";
                    String role = "${data['role']}";

                    userController.text = userName;
                    emailController.text = email;
                    roleController.text = role;

                    return Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image(
                                  image: AssetImage(tProfileImage),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: tFormHeight - 10),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextField(
                                    controller: userController,
                                    decoration: InputDecoration(
                                      label: Text('UserName'),
                                      prefixIcon:
                                          Icon(Icons.person_outline_rounded),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      label: Text('Email'),
                                      prefixIcon: Icon(Icons.email_outlined),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: roleController,
                                    decoration: InputDecoration(
                                      label: Text('Role'),
                                      prefixIcon: Icon(Icons.person_add_alt_1),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  // BUTTON
                                  Center(
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            users.doc(user.uid).update({
                                              "userName": userController.text,
                                              "email": emailController.text,
                                              "role": roleController.text,
                                            });
                                          }
                                        },
                                        icon: Text(
                                          "Update",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

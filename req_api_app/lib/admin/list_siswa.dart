import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:req_api_app/user/search_testfield.dart';

final userNameController = TextEditingController();
final roleController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class DataUser extends StatefulWidget {
  const DataUser({super.key});

  @override
  State<DataUser> createState() => _tambahDataState();
}

class _tambahDataState extends State<DataUser> {
  @override
  Widget build(BuildContext context) {
    // FIREBASE API
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person_add,
                size: 40,
              ),
            ),
          )
        ],
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.black54,
        title: Text(
          "Data Mahasiswwa",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              // child: SearchTextField(),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: 'user')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!.docs
                          .map(
                            (e) => Card(
                              color: Colors.white60,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 15, 15, 15),
                                  foregroundColor:
                                      Color.fromARGB(255, 203, 132, 39),
                                  child: Text(e["userName"][0] ?? "A"),
                                ),
                                title: Text(e['userName'] ?? ""),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e['role'],
                                    ),
                                    // Text(
                                    //   e['gender'],
                                    // ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit_note,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        // print("Masukkk");
                                        userNameController.text = e["userName"];
                                        roleController.text = e["role"];
                                        // genderController.text = e["gender"];
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Form(
                                                    // key: _keyDialogForm,
                                                    child: Column(
                                                      children: <Widget>[
                                                        TextFormField(
                                                          readOnly: true,
                                                          controller:
                                                              userNameController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  icon: Icon(Icons
                                                                      .people),
                                                                  hintText:
                                                                      "Input Your Name"),
                                                          // maxLength: 8,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextFormField(
                                                          readOnly: true,
                                                          controller:
                                                              roleController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  icon: Icon(Icons
                                                                      .email),
                                                                  hintText:
                                                                      "Input Your Email"),
                                                          // maxLength: 8,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        // TextFormField(
                                                        //   controller:
                                                        //   genderController,
                                                        //   decoration:
                                                        //   const InputDecoration(
                                                        //       icon: Icon(
                                                        //           Icons
                                                        //               .man),
                                                        //       hintText:
                                                        //       "Input Your Gender"),
                                                        //   // maxLength: 8,
                                                        //   textAlign:
                                                        //   TextAlign.start,
                                                        //   onSaved: (val) {
                                                        //     // titleController.text = val;
                                                        //   },
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    IconButton(
                                                      onPressed: () {
                                                        users.doc(e.id).update(
                                                          {
                                                            'userName':
                                                                userNameController
                                                                    .text,
                                                            'role':
                                                                roleController
                                                                    .text,
                                                            // 'gender':
                                                            // genderController
                                                            //     .text,
                                                          },
                                                        );
                                                        userNameController
                                                            .clear();
                                                        roleController.clear();
                                                        // genderController
                                                        //     .clear();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit_attributes,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        users.doc(e.id).delete();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

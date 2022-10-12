import 'package:crud_base/models/User.dart';
import 'package:crud_base/screens/EditUser.dart';
import 'package:crud_base/screens/addUser.dart';
import 'package:crud_base/screens/ViewUsers.dart';
import 'package:crud_base/services/userService.dart';
import 'package:flutter/material.dart';

import 'core/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList = <User>[];
  final _userService = UserService();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    _userList = <User>[];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar('User Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 45.0,
                    width: 300.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: Colors.teal),
                      boxShadow: [
                        BoxShadow(
                          color: green.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 45,
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/icons/search.png',
                          height: 25,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 7),
                  Container(
                    height: 45.0,
                    width: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: teal,
                      boxShadow: [
                        BoxShadow(
                          color: teal.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/icons/adjust.png',
                      color: white,
                      height: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewUser(
                                        user: _userList[index],
                                      )));
                        },
                        leading: const Icon(Icons.person),
                        title: Text(_userList[index].name ?? ''),
                        subtitle: Text(_userList[index].contact ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditUser(
                                                user: _userList[index],
                                              ))).then((data) {
                                    if (data != null) {
                                      getAllUserDetails();
                                      _showSuccessSnackBar(
                                          'User Detail Updated Success');
                                    }
                                  });
                                  ;
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.teal,
                                )),
                            IconButton(
                                onPressed: () {
                                  _deleteFormDialog(
                                      context, _userList[index].id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddUser()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('User Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

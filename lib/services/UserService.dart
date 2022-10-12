import 'dart:async';

import 'package:crud_base/helpers/repository.dart';
import 'package:crud_base/models/User.dart';

class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  //Save User
  SaveUser(User user) async {
    return await _repository.insertData('users', user.userMap());
  }

  //Read All Users
  readAllUsers() async {
    return await _repository.readData('users');
  }

  //Edit User
  UpdateUser(User user) async {
    return await _repository.updateData('users', user.userMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById('users', userId);
  }

  searchName(name) async {
    return await _repository.readDataByName('users', name);
  }

  searchContact(contact) async {
    return await _repository.readDataByContact('users', contact);
  }
}

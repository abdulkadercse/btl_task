import 'dart:convert';
import 'package:btl_task/model/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../const/server_config.dart';

class UserController extends GetxController  {
  //get data from api
  Future<List<User>> getData() async {
    var url = Uri.parse(ServerConfig.baseUrl);
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => User.fromJson(e)).toList();
  }
}
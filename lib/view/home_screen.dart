import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/app_colors.dart';
import '../controller/user_controller.dart';
import '../model/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  //_makePhoneCall
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    var userData = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: const Text("Home Screen",style: kTextStyleColor,),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: FutureBuilder<List<User>>(
              future: userData.getData(),
              builder: (context, snapShort) {
                if (snapShort.hasData) {
                  return ListView.builder(
                      itemCount: snapShort.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var userData = snapShort.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: kDeepPurpleAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                "Name: ${userData.name}",
                                style: kTextStyleColor,
                              ),
                              subtitle: Text("Email : ${userData!.email}",
                                  style: kTextStyleColor),
                              trailing: GestureDetector(
                                onTap: () {
                                  _makePhoneCall(userData.phone);
                                },
                                child: const Icon(
                                  Icons.phone,
                                  color: kWhite,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kRead,
                    ),
                  );
                }
              })),
    );
  }
}

import 'dart:convert';
import 'package:api_practice/core/api_requests.dart';
import 'package:api_practice/core/auth_service.dart';
import 'package:api_practice/model/profile_model.dart';
import 'package:api_practice/utils/shared_prefs.dart';
import 'package:api_practice/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileModel profileData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    final userId = await SharedPrefs.getIntValue(key: SharedPrefs.userIdKey);
    if (userId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await AuthService.logoutUser(context);
      });
      return;
    }

    final response = await http.get(Uri.parse('${ApiRequests.users}/$userId'));
    profileData = ProfileModel.fromJson(jsonDecode(response.body));
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isLoading
            ? Center(
                child: Text(
                  "Loading User Data",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              )
            : Align(
                alignment: Alignment.topCenter,
                child: ProfileCard(
                  profileDetails: profileData,
                ),
              ));
  }
}

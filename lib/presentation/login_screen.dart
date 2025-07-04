import 'package:api_practice/core/api_requests.dart';
import 'package:api_practice/core/api_service.dart';
import 'package:api_practice/model/login_model.dart';
import 'package:api_practice/presentation/dashboard_screen.dart';
import 'package:api_practice/utils/custom_snackbar.dart';
import 'package:api_practice/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernamerController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> provideLogin({
    required String providedUsername,
    required String providedPassword,
  }) async {
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });

    final setLogin =
        LoginModel(username: providedUsername, password: providedPassword);

    final response = await ApiService.post(
      url: ApiRequests.login,
      body: setLogin.toJson(),
    );

    final userToken = response["token"];
    if (userToken == null) throw Exception("Token not found");

    Map<String, dynamic> decodedToken = JwtDecoder.decode(userToken);
    final userId = decodedToken["sub"];
    await SharedPrefs.setIntValue(key: SharedPrefs.userIdKey, value: userId);

    if (!mounted) return;

    CustomSnackbar.successSnackBar(
        context: context, message: "Login successful");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
      (val) => false,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: usernamerController,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  enabled: !isLoading,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final password = passwordController.text.trim();
                    final username = usernamerController.text.trim();
                    if (password.isNotEmpty && username.isNotEmpty) {
                      await provideLogin(
                          providedUsername: username,
                          providedPassword: password);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please fill out the empty details',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Login',
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

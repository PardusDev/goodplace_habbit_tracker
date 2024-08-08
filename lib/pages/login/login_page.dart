import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/onboarding/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Kullanıcı giriş işlemini burada gerçekleştirin
            // ...

            SharedPreferences prefs = await SharedPreferences.getInstance();
            bool seenOnboarding = prefs.getBool('onboarding') ?? false;

            if (seenOnboarding) {
              Navigator.pushReplacementNamed(
                // ignore: use_build_context_synchronously
                context,
                "/homepage",
              );
            } else {
              Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const OnBoarding()),
              );
            }
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}

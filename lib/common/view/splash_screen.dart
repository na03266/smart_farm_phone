import 'package:flutter/material.dart';
import 'package:smart_farm_phone/common/const/colors.dart';
import 'package:smart_farm_phone/common/const/data.dart';
import 'package:smart_farm_phone/common/layout/default_layout.dart';
import 'package:smart_farm_phone/common/view/root_tab.dart';
import 'package:smart_farm_phone/user/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    deleteToken();
    checkToken();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _initializeApp();
    // });
  }

  // Future<void> _initializeApp() async {
  //
  // }
  void deleteToken() async{
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    if (refreshToken == null || accessToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => RootTab(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'name',
            //   width: MediaQuery.of(context).size.width / 2,
            // ),
            SizedBox(height: 16),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

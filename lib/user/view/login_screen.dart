import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm_phone/common/component/custom_text_form_field.dart';
import 'package:smart_farm_phone/common/const/data.dart';
import 'package:smart_farm_phone/common/layout/default_layout.dart';
import 'package:smart_farm_phone/common/view/root_tab.dart';

import '../../common/const/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    final dio = Dio();

    //  localhost
    final emulatorIp = '10.0.2.2:3000';
    final simulatorIp = '127.0.0.1:3000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(height: 16),
                CustomTextFormField(
                  hintText: '아이디',
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  hintText: '비밀번호',
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () async {
                    final rawString = '$username:$password';

                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post(
                      'http://$ip/auth/login',
                      options: Options(
                        headers: {'authorization': 'Basic $token'},
                      ),
                    );

                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await storage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: accessToken);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RootTab(),
                      ),
                    );
                    print(resp.data);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: BUTTON_COLOR,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('로그인',
                    style: TextStyle(
                      color: DARK_TEXT_COLOR,
                      fontSize: 16
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    // return  Image.asset(
    //   "name",
    //   width: MediaQuery.of(context).size.width / 3 * 2,
    // );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:service_manager_client/components/text_field.dart';
import 'package:service_manager_client/login/logic.dart';

class LoginPage extends StatelessWidget {
  static final logic = GetIt.I<LoginLogic>();
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .1,
            ),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (size.height) * .04,
                  vertical: (size.height) * .02,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * .01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'ورود',
                            style: TextStyle(fontSize: 48),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * .03),
                      child: TextFieldC(
                        hintText: 'نام کاربری یا شماره تلفن',
                        icon: Icons.perm_identity_outlined,
                        controller: logic.usernameCtrl,
                        errMsg: logic.usernameErrMsg,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: size.height * .03,
                        top: size.height * .01,
                      ),
                      child: TextFieldC(
                        hintText: 'رمز عبور',
                        icon: Icons.password_outlined,
                        controller: logic.passwordCtrl,
                        errMsg: logic.passwordErrMsg,
                        obscure: true,
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: logic.hasErr,
                      builder: (_, __, ___) {
                        return Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            if (logic.hasErr.value)
                              const Text(
                                'نام کاربری/رمزعبور اشتباه است.',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: Colors.red),
                              )
                          ],
                        );
                      },
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        TextButton(
                          onPressed: () async => await Navigator.of(context)
                              .popAndPushNamed('/signup'),
                          child: const Text(
                            'برای ثبت نام کلیک کنید',
                            overflow: TextOverflow.clip,
                            textDirection: TextDirection.rtl,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async => await logic.loginPressed()
                                ? await Navigator.of(context).popAndPushNamed(
                                    '/dashboard/${logic.userType}')
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                'ورود',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:service_manager_client/components/text_field.dart';
import 'package:service_manager_client/signup/logic.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  Widget pendView(BuildContext context, SignUpPageLogic logic) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Size size = MediaQuery.of(context).size;
    Size signupBtnMinSize = Size(size.width * .5, size.height * .06);
    SizedBox sectionPad = SizedBox(height: size.height * .03);
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * .02,
        right: size.width * .02,
        top: size.height * .03,
        bottom: size.height * .03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFieldC(
            hintText: 'نام و نام خانوادگی',
            icon: Icons.title,
            controller: logic.fullnameCtrl,
            errMsg: logic.fullnameErrMsg,
          ),
          TextFieldC(
            hintText: 'شماره موبایل',
            icon: Icons.phone,
            controller: logic.phoneCtrl,
            errMsg: logic.phoneErrMsg,
          ),
          TextFieldC(
            hintText: 'رمز عبور',
            icon: Icons.password,
            controller: logic.passwordCtrl,
            errMsg: logic.passwordErrMsg,
            obscure: true,
          ),
          TextFieldC(
            hintText: 'تکرار رمز عبور',
            icon: Icons.password,
            controller: logic.confirmPasswordCtrl,
            errMsg: logic.confirmPasswordErrMsg,
            obscure: true,
          ),
          sectionPad,
          ElevatedButton(
            onPressed: () async => (await logic.signupPressed())
                ? await Navigator.of(context).popAndPushNamed('/login') 
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: signupBtnMinSize,
              backgroundColor: secondaryColor,
            ),
            child: const Text(
              'ثبت نام',
              style: TextStyle(fontSize: 24),
            ),
          ),
          sectionPad,
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () async =>
                    await Navigator.of(context).popAndPushNamed('/login'),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: const Text(
                    'اگر از قبل حساب ساخته‌اید، وارد شوید!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  CircularProgressIndicator waitIndicator(Size size) {
    return const CircularProgressIndicator.adaptive();
  }

  @override
  Widget build(BuildContext context) {
    SignUpPageLogic logic = GetIt.I<SignUpPageLogic>();
    Size size = MediaQuery.of(context).size;
    Size cardSizePad = Size(size.width * .08, size.height * .1);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: cardSizePad.height,
                left: cardSizePad.width,
                right: cardSizePad.width,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 20,
                child: ValueListenableBuilder(
                  valueListenable: logic.signal,
                  builder: (_, __, ___) {
                    bool isPend2Insert =
                        logic.state.value == SignUpPageStates.pend;
                    logic.state.value == SignUpPageStates.succeed
                        ? Future.microtask(() =>
                            Navigator.of(context).popAndPushNamed('/dashboard'))
                        : null;
                    return isPend2Insert
                        ? pendView(context, logic)
                        : SizedBox(
                            height: size.height * .5,
                            child: Center(child: waitIndicator(size)),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

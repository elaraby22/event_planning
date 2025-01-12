import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/model/myUser.dart';
import 'package:event_planning/providers/event_list_provider.dart';
import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/ui/home_screen/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:event_planning/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../home_screen/tabs/widget/custom_text_field.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'elaraby');
  var emailController = TextEditingController(text: 'elaraby@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var rePasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyles.medium20Black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.02),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AssetsManager.logo),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter name'; // invalid
                    }
                    return null; // valid
                  },
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Image.asset(AssetsManager.iconName),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter email';
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Image.asset(AssetsManager.iconEmail),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                    controller: passwordController,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter password';
                      }
                      if (text.length < 6) {
                        return 'Password should be at least 6 chars';
                      }
                      return null;
                    },
                    hintText: AppLocalizations.of(context)!.password,
                    prefixIcon: Image.asset(AssetsManager.iconPassword),
                    suffixIcon: Image.asset(AssetsManager.iconShowPassword),
                    obscureText: true),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextField(
                    controller: rePasswordController,
                    keyboardType: TextInputType.phone,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter re-password';
                      }
                      if (text.length < 6) {
                        return 'Re-Password should be at least 6 chars';
                      }
                      if (text != passwordController.text) {
                        return "Re-Password doesn't match Password";
                      }
                    },
                    hintText: AppLocalizations.of(context)!.re_password,
                    prefixIcon: Image.asset(AssetsManager.iconPassword),
                    suffixIcon: Image.asset(AssetsManager.iconShowPassword),
                    obscureText: true),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                    text: AppLocalizations.of(context)!.create_account,
                    textStyle: AppStyles.medium20White,
                    backgroundColor: AppColors.primaryLight,
                    onButtonClicked: register),
                SizedBox(
                  height: height * 0.02,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: AppLocalizations.of(context)!.already_have_account,
                      style: AppStyles.medium16Black),
                  WidgetSpan(
                      child: SizedBox(
                    width: width * 0.02,
                  )),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                      text: AppLocalizations.of(context)!.login,
                      style: AppStyles.bold16Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight)),
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      // register
      //todo: show loading
      DialogUtils.showLoading(
          context: context, message: AppLocalizations.of(context)!.loading);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        var eventListProvider =
            Provider.of<EventListProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        await FirebaseUtils.addUserToFireStore(myUser);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.register_successfully,
            title: AppLocalizations.of(context)!.success,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              eventListProvider.changeSelectedIndex(
                  eventListProvider.selectedIndex,
                  userProvider.currentUser!.id);
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message:
                  AppLocalizations.of(context)!.password_provided_is_too_weak,
              title: AppLocalizations.of(context)!.error,
              posActionName: AppLocalizations.of(context)!.ok);
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message:
                  AppLocalizations.of(context)!.account_already_exits_for_email,
              title: AppLocalizations.of(context)!.error,
              posActionName: AppLocalizations.of(context)!.ok);
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: AppLocalizations.of(context)!.error,
            posActionName: AppLocalizations.of(context)!.ok);
      }
    }
  }
}

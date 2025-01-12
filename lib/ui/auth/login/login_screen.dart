import 'package:event_planning/firebase_utils.dart';
import 'package:event_planning/providers/user_provider.dart';
import 'package:event_planning/ui/auth/register/register_screen.dart';
import 'package:event_planning/ui/home_screen/home_screen.dart';
import 'package:event_planning/ui/home_screen/tabs/widget/custom_elevated_button.dart';
import 'package:event_planning/ui/home_screen/tabs/widget/custom_text_field.dart';
import 'package:event_planning/utils/app_colors.dart';
import 'package:event_planning/utils/app_styles.dart';
import 'package:event_planning/utils/assets_manager.dart';
import 'package:event_planning/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../providers/event_list_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'elaraby@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.05),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AssetsManager.logo),
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
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          //todo: navigate to forget password screen
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forget_password,
                          style: AppStyles.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight),
                        )),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                  onButtonClicked: login,
                  text: AppLocalizations.of(context)!.login,
                  textStyle: AppStyles.medium20White,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: AppLocalizations.of(context)!.do_not_have_account,
                      style: AppStyles.medium16Black),
                  WidgetSpan(
                      child: SizedBox(
                    width: width * 0.02,
                  )),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context)
                              .pushReplacementNamed(RegisterScreen.routeName);
                        },
                      text: AppLocalizations.of(context)!.create_account,
                      style: AppStyles.bold16Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight)),
                ])),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 2,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: AppStyles.medium16Primary,
                    ),
                    Expanded(
                      child: Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 2,
                        color: AppColors.primaryLight,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                CustomElevatedButton(
                  onButtonClicked: () {
                    //todo: login with google
                    // signInWithGoogle();
                  },
                  textStyle: AppStyles.medium20Primary,
                  text: AppLocalizations.of(context)!.login_with_google,
                  backgroundColor: AppColors.whiteColor,
                  iconButton: Image.asset(AssetsManager.iconGoogle),
                  borderSide: AppColors.primaryLight,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      // login
      //todo: show loading
      DialogUtils.showLoading(
          context: context, message: AppLocalizations.of(context)!.loading);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.login_successfully,
            title: AppLocalizations.of(context)!.success,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              eventListProvider.changeSelectedIndex(
                  eventListProvider.selectedIndex,
                  userProvider.currentUser!.id);
              eventListProvider.getFavoriteEvent(userProvider.currentUser!.id);
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: AppLocalizations.of(context)!.no_user_found,
              title: AppLocalizations.of(context)!.error,
              posActionName: AppLocalizations.of(context)!.ok);
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: AppLocalizations.of(context)!.wrong_password_for_user,
              title: AppLocalizations.of(context)!.error,
              posActionName: AppLocalizations.of(context)!.ok);
        } else if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: AppLocalizations.of(context)!.supplied_auth_credential,
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
        print(e.toString());
      }
    }
  }

// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//
//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
//
// }
}

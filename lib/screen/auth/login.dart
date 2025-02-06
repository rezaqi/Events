import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/images.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/core/func/langage.dart';
import 'package:evently/firebase/firebase.dart';
import 'package:evently/widget/auth/both_text_form.dart';
import 'package:evently/widget/auth/countries.dart';
import 'package:evently/widget/customs/button.dart';
import 'package:evently/widget/customs/dialgo.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isEn = true;
  bool isLoading = false;

  TextEditingController? cEmail;
  TextEditingController? cPass;

  @override
  void initState() {
    cEmail = TextEditingController();
    cPass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cEmail!.dispose();
    cPass!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.logoScreen),
                      BothTextForm(
                        formState: formKey,
                        cEmail: cEmail,
                        cPass: cPass,
                      ),
                      CustomButton(
                          ontap: () {
                            FirebaseManager.signinEmailPass(
                                cEmail!.text, cPass!.text, () {
                              Navigator.pushReplacementNamed(
                                  context, AppRouts.home);
                            }, () {
                              return customShowDialog(context, "Loading", () {},
                                  CircularProgressIndicator());
                            }, (e) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text("your email or password is wrong "),
                              ));
                              setState(() {});
                            }, () {
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("you should verify your email "),
                              ));
                              setState(() {});
                            });
                          },
                          color: AppColors.primaryColor,
                          widget: Text(
                            "login".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppColors.white),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "do_not_have_acc".tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRouts.signup);
                            },
                            child: Text(
                              "sign_up".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 5,
                            width: 150,
                            child: Divider(
                              endIndent: 10,
                              thickness: 1,
                              height: 10,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            "Or",
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          SizedBox(
                            height: 5,
                            width: 150,
                            child: Divider(
                              indent: 10,
                              thickness: 1,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        ontap: () {
                          FirebaseManager.signInWithGoogle(() {
                            Navigator.pushReplacementNamed(
                                context, AppRouts.home);
                          });
                        },
                        widget: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "log_google".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.primaryColor),
                            ),
                            Image.asset(AppImages.google),
                          ],
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            changeLanguage(
                              context,
                            );
                          },
                          child: Countries(
                              isEn: context.locale == Locale("en")
                                  ? isEn
                                  : !isEn))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

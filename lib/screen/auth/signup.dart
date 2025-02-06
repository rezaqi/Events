import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/colors.dart';
import 'package:evently/core/class/images.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/core/func/langage.dart';
import 'package:evently/firebase/firebase.dart';
import 'package:evently/widget/auth/countries.dart';
import 'package:evently/widget/auth/signup/text_form_list.dart';
import 'package:evently/widget/customs/button.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isEn = true;
  bool isLoading = false;

  TextEditingController? cEmail;

  TextEditingController? cName;
  TextEditingController? cPass;

  TextEditingController? cRPass;

  @override
  void initState() {
    cEmail = TextEditingController();
    cName = TextEditingController();

    cPass = TextEditingController();
    cRPass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cEmail!.dispose();
    cName!.dispose();

    cPass!.dispose();
    cRPass!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text("signup_register".tr()),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.logoScreen),
                    TextFormList(
                      cEmail: cEmail,
                      cName: cName,
                      cPass: cPass,
                      cRPass: cRPass,
                      formState: formKey,
                    ),
                    CustomButton(
                        ontap: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseManager.createUserWithEmailAndPassword(
                                cEmail!.text, cPass!.text, cName!.text, () {
                              Navigator.pushReplacementNamed(
                                  context, AppRouts.login);
                            }, () {
                              return setState(() {
                                Center(child: CircularProgressIndicator());
                              });
                            }, (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Erorr $e "),
                              ));
                              setState(() {});
                            });
                          }
                        },
                        color: AppColors.primaryColor,
                        widget: Text(
                          "sign_up".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppColors.white),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "already_have_account".tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "login".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          changeLanguage(context);
                        },
                        child: Countries(
                            isEn:
                                context.locale == Locale("en") ? isEn : !isEn))
                  ],
                ),
              ),
            ),
    );
  }
}

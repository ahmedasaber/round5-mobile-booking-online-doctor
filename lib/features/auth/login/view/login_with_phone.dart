import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mobile_booking_online_doctor/core/validators/valiators.dart';
import 'package:mobile_booking_online_doctor/features/auth/login/view/widgets/signin_auth_divider.dart';
import 'package:mobile_booking_online_doctor/features/auth/login/view/widgets/signin_auth_elevated_button.dart';
import 'package:mobile_booking_online_doctor/features/auth/login/view/widgets/signin_custom_checkbox.dart';
import 'package:mobile_booking_online_doctor/features/auth/login/view/widgets/signin_social_media_container.dart';
import '../../../../core/helpers/assets.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_state.dart';

class LoginScreenWithPhone extends StatefulWidget {
  const LoginScreenWithPhone({super.key});

  @override
  State<LoginScreenWithPhone> createState() => _LoginScreenWithPhoneState();
}

class _LoginScreenWithPhoneState extends State<LoginScreenWithPhone> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.light,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<LoginWithPhoneCubit, LoginState>( // ✅ Cubit الجديد
        listener: (context, state) async {
          if (state is LoginSuccess) {
            String phoneNumber = state.loginModel.data.user.phone;
            print("📱 Phone Number from API: $phoneNumber");

            final prefs = await SharedPreferences.getInstance();
            await prefs.setString("phone", phoneNumber);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Phone: $phoneNumber")),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: TextStyles.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TextStyles.spaceBtwSections * 2),
                    Center(
                      child: Image.asset(
                        Assets.splashHeart,
                        color: ColorsManger.primaryColor,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    const SizedBox(height: TextStyles.spaceBtwItems),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        Assets.signInTitle,
                        style: TextStyle(fontSize: 32, fontFamily: "Georgia"),
                      ),
                    ),
                    const SizedBox(height: TextStyles.spaceBtwSections * 2),

                    // حقل رقم الموبايل
                    IntlPhoneField(
                      controller: phoneController,
                      validator: (value) => Validators.validatePhone(value?.number),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF5F6F7),
                        labelText: Assets.hintPhone,
                        labelStyle: const TextStyle(color: ColorsManger.dark),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(TextStyles.borderRadiusLg),
                          borderSide: const BorderSide(color: Color(0xFFF5F6F7)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(TextStyles.borderRadiusLg),
                          borderSide: const BorderSide(color: Color(0xFFF5F6F7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(TextStyles.borderRadiusLg),
                          borderSide: const BorderSide(color: Color(0xFFF5F6F7)),
                        ),
                      ),
                      initialCountryCode: 'EG',
                      dropdownIconPosition: IconPosition.trailing,
                      style: const TextStyle(color: ColorsManger.dark),
                      onChanged: (phone) async {
                        print("📲 Typed Phone: ${phone.completeNumber}");
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString("phone", phone.completeNumber);
                      },
                    ),

                    const SizedBox(height: TextStyles.spaceBtwItems / 2),
                    SigninCustomCheckbox(),
                    const SizedBox(height: TextStyles.spaceBtwSections * 2),

                    // زر تسجيل الدخول
                    SigninAuthElevatedButton(
                      buttonTitle: "Sign in",
                      primaryButton: true,
                      onPressed: () {
                        if (phoneController.text.isNotEmpty) {
                          context.read<LoginWithPhoneCubit>().loginUser( // ✅ Cubit الجديد
                            phoneController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please enter your phone number")),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: TextStyles.spaceBtwItems),
                    SigninAuthDivider(),
                    const SizedBox(height: TextStyles.spaceBtwItems),

                    // أزرار السوشيال ميديا
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SigninSocialMediaContainer(image: Assets.facebookIcon),
                        const SizedBox(width: TextStyles.spaceBtwItems),
                        SigninSocialMediaContainer(image: Assets.googleIcon),
                        const SizedBox(width: TextStyles.spaceBtwItems),
                        SigninSocialMediaContainer(image: Assets.appleIcon),
                      ],
                    ),
                    const SizedBox(height: TextStyles.spaceBtwItems),

                    // رابط إنشاء حساب
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: ColorsManger.darkGrey),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushReplacementNamed("/signup"),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: ColorsManger.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
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

import 'package:flutter/material.dart';
import 'package:flutter_instagram/resources/auth_methods.dart';
import 'package:flutter_instagram/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram/screens/mobile_screen_layout.dart';
import 'package:flutter_instagram/screens/singup_screen.dart';
import 'package:flutter_instagram/screens/web_screen_layout.dart';
import 'package:flutter_instagram/utils/colors.dart';
import 'package:flutter_instagram/utils/utils.dart';
import 'package:flutter_instagram/widgets/text_field_input.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().logInUser(
        email: _emailController.text, password: _passwordController.text);
    if (result == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout()),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show snackbar
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                // SVG image
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  height: 64,
                  colorFilter:
                      const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                ),
                const SizedBox(
                  height: 64,
                ),
                // Text field for Email
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                ),
                // Text field for Password
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                // Button for Login
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Log in'),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                // Transitioning for Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: navigateToSignUp,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: const Text(
                          " Sign up.",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
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
    );
  }
}

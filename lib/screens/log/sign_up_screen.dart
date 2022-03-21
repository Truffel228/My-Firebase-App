import 'package:fire_base_app/shared/consts.dart';
import 'package:fire_base_app/shared/locator.dart';
import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/services/auth/auth_service.dart';
import 'package:fire_base_app/services/database/database_service.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({required this.toogleScreen, Key? key}) : super(key: key);

  final VoidCallback toogleScreen;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final DatabaseService _database = locator.get<DatabaseService>();
  final AuthService _auth = locator.get<AuthService>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        actions: [
          AppButton(
            child: Text('Sign In'),
            onPressed: widget.toogleScreen,
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                AppTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(emailRegExp),
                  ],
                  validator: _emailValidator,
                  hintText: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(passwordRegExp),
                  ],
                  validator: _passwordValidator,
                  hintText: 'Password',
                  controller: _passwordController,
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _authSignUpEmailPassword();
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _passwordValidator(String? val) {
    if (val!.length < 6) {
      return 'Password must be at least 6 symbols';
    }
    return null;
  }

  String? _emailValidator(String? val) {
    if (val!.isEmpty) {
      return 'Email shouldn\'t be empty';
    }
    return null;
  }

  Future<void> _authSignUpEmailPassword() async {
    final AppUser? user = await _auth.signUpEmailPassword(
        _emailController.text, _passwordController.text);
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed'),
        ),
      );
    } else {
      _database.setInitialUserData(user.uid);
    }
  }
}

import 'package:fire_base_app/services/auth/auth_service_interface.dart';
import 'package:fire_base_app/shared/consts.dart';
import 'package:fire_base_app/exceptions/service_exceptions/auth_service_exception.dart';
import 'package:fire_base_app/shared/locator.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, required this.toogleScreen}) : super(key: key);

  final VoidCallback toogleScreen;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthServiceInterface _auth = locator.get<AuthServiceInterface>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _isUserFound = true;
  var _isWrongPassword = false;
  var _isFailed = false;
  var _failedText = '';
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
          actions: [
            Center(
              child: AppButton(
                title: 'Sign Up',
                onTap: widget.toogleScreen,
              ),
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
                    validator: _emailValidator,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(emailRegExp),
                    ],
                    onChanged: (_) {
                      _resetState();
                    },
                    hintText: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    validator: _passwordValidator,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(passwordRegExp),
                    ],
                    onChanged: (_) {
                      _resetState();
                    },
                    hintText: 'Password',
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  if (_isWrongPassword)
                    Text(
                      'Wrong password',
                      style: theme.textTheme.bodyText1!
                          .copyWith(color: theme.errorColor),
                    ),
                  if (!_isUserFound)
                    Text(
                      'User with this email wasn\'t found',
                      style: theme.textTheme.bodyText1!
                          .copyWith(color: theme.errorColor),
                    ),
                  if (_isFailed)
                    Text(
                      _failedText,
                      style: theme.textTheme.bodyText1!
                          .copyWith(color: theme.errorColor),
                    ),
                  const SizedBox(height: 40),
                  _isLoading
                      ? const LoadingWidget()
                      : TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              // As you said you dont need elevation. I'm returning 0 in both case
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return theme.primaryColor;
                                }
                                return theme
                                    .primaryColor; // Defer to the widget's default.
                              },
                            ),
                          ),
                          onPressed: _signIn,
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Try app by logging in ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Anonymously',
                          style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _authSignInAnon,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    _resetState();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await _authSignInEmailPassword();
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _resetState() {
    setState(() {
      _isUserFound = true;
      _isWrongPassword = false;
      _isFailed = false;
      _failedText = '';
    });
  }

  String? _emailValidator(String? val) {
    if (val!.isEmpty) {
      return 'Email field can\'t be empty';
    }
    return null;
  }

  String? _passwordValidator(String? val) {
    if (val!.isEmpty) {
      return 'Password field can\'t be empty';
    }
    return null;
  }

  Future<void> _authSignInAnon() async {
    dynamic user = await _auth.signInAnon();
    if (user == null) {
      setState(() {
        _isFailed = true;
        _failedText = 'Signing in anonymously failed';
      });
    }
  }

  Future<void> _authSignInEmailPassword() async {
    dynamic user;

    try {
      user = await _auth.signInEmailPassword(
          _emailController.text, _passwordController.text);
    } on AuthServiceException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          setState(() {
            _isUserFound = false;
          });
          return;
        case 'wrong-password':
          setState(() {
            _isWrongPassword = true;
          });
          return;
      }
    }

    if (user == null) {
      setState(() {
        _isFailed = true;
        _failedText = 'Signing in failed';
      });
    }
  }
}

import 'package:coronavirus/theme/assets.dart';
import 'package:coronavirus/theme/colors.dart';
import 'package:coronavirus/theme/fontstyle.dart';
import 'package:coronavirus/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _typeController = TextEditingController();
  final _idController = TextEditingController();
  final _passController = TextEditingController();

  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  Images.femenino,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  bottom: 38,
                  left: 16,
                  child: Text(
                    "Bienvenido a:",
                    style: arial.copyWith(
                      fontSize: 12,
                      color: ThemeColors.grey,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 24,
                  child: Text(
                    "Evertec",
                    style: arialbold.copyWith(
                      fontSize: 34,
                      color: ThemeColors.grey,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8 * 4, vertical: 8 * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Tipo Documento:",
                      style: arial.copyWith(fontSize: 14),
                    ),
                  ),
                  TextFormField(
                    controller: _typeController,
                    decoration: InputDecoration(
                      filled: true,
                      alignLabelWithHint: true,
                      hintStyle: arial.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      fillColor: Colors.transparent,
                      focusedBorder: textFormFieldBorder,
                      enabledBorder: textFormFieldBorder,
                      contentPadding: textFormFieldPadding,
                    ),
                  ),
                  const Gap(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Número Documento:",
                      style: arial.copyWith(fontSize: 14),
                    ),
                  ),
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      filled: true,
                      alignLabelWithHint: true,
                      hintStyle: arial.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      fillColor: Colors.transparent,
                      focusedBorder: textFormFieldBorder,
                      enabledBorder: textFormFieldBorder,
                      contentPadding: textFormFieldPadding,
                    ),
                  ),
                  const Gap(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Contraseña:",
                      style: arial.copyWith(fontSize: 14),
                    ),
                  ),
                  TextFormField(
                    controller: _passController,
                    obscureText: _obscured,
                    decoration: InputDecoration(
                      filled: true,
                      alignLabelWithHint: true,
                      hintStyle: arial.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      fillColor: Colors.transparent,
                      focusedBorder: textFormFieldBorder,
                      enabledBorder: textFormFieldBorder,
                      contentPadding: textFormFieldPadding,
                      suffixIcon: GestureDetector(
                        onTap: _toggleObscured,
                        child: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const Gap(32),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 8),
                      ),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        ThemeColors.primaryColor,
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: arialbold.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Center(
                    child: Text(
                      "Registrar Usuario",
                      style: arial.copyWith(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Gap(40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            Images.google,
                            width: 60,
                            height: 60,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            Images.facebook,
                            width: 60,
                            height: 60,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Image.asset(
                            Images.instagram,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

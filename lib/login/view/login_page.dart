import 'package:coronavirus/login/login.dart';
import 'package:coronavirus/login/model/types.dart';
import 'package:coronavirus/theme/assets.dart';
import 'package:coronavirus/theme/colors.dart';
import 'package:coronavirus/theme/fontstyle.dart';
import 'package:coronavirus/theme/loading.dart';
import 'package:coronavirus/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = "login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) => LoginBloc(
          repository: RepositoryProvider.of<UserRepository>(context),
        ),
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  String? _type;
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
      resizeToAvoidBottomInset: true,
      appBar: null,
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            current.status == LoginStatus.notFound ||
            current.status == LoginStatus.registered ||
            current.status == LoginStatus.failure ||
            current.status == LoginStatus.success,
        listener: (context, state) {
          if (state.status == LoginStatus.notFound) {
            _register();
          } else if (state.status == LoginStatus.failure ||
              state.status == LoginStatus.registered) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ThemeColors.primaryColor,
              ),
            );
          } else if (state.status == LoginStatus.success) {
            /* Navigator.of(context).pushNamedAndRemoveUntil(
              "/home",
              (route) => false,
            ); */
          }
        },
        builder: (context, state) {
          if (state.status == LoginStatus.loading) {
            return const CircularLoading();
          }
          return Column(
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
                    horizontal: 8 * 4,
                    vertical: 8 * 3,
                  ),
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
                      DropdownButtonFormField<String>(
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
                          border: textFormFieldBorder,
                          contentPadding: textFormFieldPadding,
                        ),
                        value: _type,
                        items: documentTypes.entries.map((item) {
                          return DropdownMenuItem(
                            value: item.key,
                            child: Text(
                              item.value,
                              style: arial.copyWith(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _type = value);
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Seleccione una opción';
                          }
                          return null;
                        },
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
                          border: textFormFieldBorder,
                          contentPadding: textFormFieldPadding,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Número de documento requerido";
                          }
                          return null;
                        },
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
                          border: textFormFieldBorder,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Contraseña requerida";
                          }
                          return null;
                        },
                      ),
                      const Gap(32),
                      ElevatedButton(
                        onPressed: _submit,
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
                        child: InkWell(
                          onTap: () => _alert("Registrar Usuario"),
                          child: Text(
                            "Registrar Usuario",
                            style: arial.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const Gap(40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => _alert("Google"),
                              child: Image.asset(
                                Images.google,
                                width: 60,
                                height: 60,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () => _alert("Facebook"),
                              child: Image.asset(
                                Images.facebook,
                                width: 60,
                                height: 60,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () => _alert("Instagram"),
                              child: Image.asset(
                                Images.instagram,
                                width: 60,
                                height: 60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _submit() {
    String? error;
    if (!_formKey.currentState!.validate()) {
      error = 'Falta completar campos';
    }
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: ThemeColors.primaryColor,
        ),
      );
      return;
    }
    BlocProvider.of<LoginBloc>(context).add(
      LoginSubmit(
        type: _type!,
        id: _idController.text,
        pass: _passController.text,
      ),
    );
  }

  void _register() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("CORONAVIRUS", textAlign: TextAlign.center),
          content: const Text(
            "El usuario no ha sido encontrado.\n¿Desea registrar el usuario?",
            style: arial,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<LoginBloc>(context).add(RegisterSubmit(
                  type: _type!,
                  id: _idController.text,
                  pass: _passController.text,
                ));
              },
              child: Text(
                "Registrar",
                style: arialbold.copyWith(color: ThemeColors.primaryColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Volver"),
            ),
          ],
        );
      },
    );
  }

  void _alert(String name) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("CORONAVIRUS", textAlign: TextAlign.center),
          content: Text(name, style: arial, textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Volver"),
            ),
          ],
        );
      },
    );
  }
}

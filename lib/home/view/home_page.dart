import 'package:coronavirus/home/home.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "home";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CovidRepository(),
      child: BlocProvider(
        create: (context) => HomeBloc(
          repository: RepositoryProvider.of<CovidRepository>(context),
        ),
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: null,
      backgroundColor: Colors.white,
      body: Center(child: Text('Home')),
    );
  }
}

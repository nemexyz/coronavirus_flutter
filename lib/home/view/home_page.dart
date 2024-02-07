import 'package:coronavirus/home/home.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:coronavirus/theme/assets.dart';
import 'package:coronavirus/theme/colors.dart';
import 'package:coronavirus/theme/fontstyle.dart';
import 'package:coronavirus/theme/loading.dart';
import 'package:coronavirus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CovidRepository(),
      child: BlocProvider(
        create: (context) => HomeBloc(
          repository: RepositoryProvider.of<CovidRepository>(context),
        )..add(LoadHome()),
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: null,
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current.status == HomeStatus.failure,
        listener: (_, state) {
          if (state.status == HomeStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ThemeColors.primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const CircularLoading();
          }
          return Column(
            children: [
              const Gap(32),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        Images.masculino,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 32,
                      left: 32,
                      child: Image.asset(
                        Images.logomAlpha,
                        width: 120,
                      ),
                    ),
                    Positioned(
                      top: 32,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(
                          Icons.exit_to_app_outlined,
                          size: 40,
                        ),
                        onPressed: () {
                          _logout(context);
                        },
                      ),
                    ),
                    Positioned(
                      top: 400,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _cardData(state),
                    ),
                    Positioned(
                      top: 280,
                      left: 16,
                      right: 16,
                      child: _cardInfo(state),
                    ),
                    Positioned(
                      top: 400,
                      right: 16,
                      child: _switchTheme(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const SizedBox();
          }
          return FloatingActionButton(
            onPressed: _regions,
            backgroundColor: ThemeColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(64),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          );
        },
      ),
    );
  }

  Widget _switchTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: 110,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          value: themeProvider.isDarkMode(),
          thumbIcon: MaterialStateProperty.all(
            Icon(
              themeProvider.isDarkMode()
                  ? Icons.nightlight_outlined
                  : Icons.wb_sunny_outlined,
              color: themeProvider.isDarkMode()
                  ? ThemeColors.lightGrey
                  : ThemeColors.grey2,
            ),
          ),
          thumbColor: MaterialStateProperty.all(
            themeProvider.isDarkMode()
                ? ThemeColors.grey
                : ThemeColors.lightGrey,
          ),
          activeTrackColor: themeProvider.isDarkMode()
              ? ThemeColors.darkGrey
              : ThemeColors.lightGrey,
          focusColor: themeProvider.isDarkMode()
              ? ThemeColors.darkGrey
              : ThemeColors.lightGrey,
          hoverColor: themeProvider.isDarkMode()
              ? ThemeColors.darkGrey
              : ThemeColors.lightGrey,
          activeColor: themeProvider.isDarkMode()
              ? ThemeColors.darkGrey
              : ThemeColors.lightGrey,
          trackOutlineColor: MaterialStateProperty.all(
            themeProvider.isDarkMode()
                ? ThemeColors.lightGrey
                : ThemeColors.darkGrey,
          ),
          trackOutlineWidth: MaterialStateProperty.all(1),
          onChanged: (_) {
            themeProvider.toggleTheme();
          },
        ),
      ),
    );
  }

  Widget _cardInfo(HomeState state) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardInfoItem(state.time, "Fecha actual", titleBold: true),
                const Gap(16),
                _cardInfoItem("Marca del dispositivo", state.deviceBrand),
                const Gap(16),
                _cardInfoItem("Modelo del dispositivo", state.deviceModel),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _cardInfoItem("Nombre del dispositivo", state.deviceName),
                const Gap(16),
                _cardInfoItem("Tipo del dispositivo", state.deviceType),
                const Gap(16),
                _cardInfoItem("SO y su versión", state.osVersion),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardInfoItem(String title, String value, {bool titleBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: menlo.copyWith(
            fontSize: titleBold ? 14 : 10,
            fontWeight: titleBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: menlo.copyWith(
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _cardData(HomeState state) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode()
            ? ThemeColors.grey
            : ThemeColors.lightGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8 * 5),
          topRight: Radius.circular(8 * 5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 90,
          bottom: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Fecha Recolección Datos: ${state.date}",
              style: menlo.copyWith(fontSize: 14),
            ),
            const Gap(16),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              children: [
                _cardDataItem(state.totalCases, 'Casos totales'),
                _cardDataItem(state.confirmedCases, 'Casos confirmados'),
                _cardDataItem(state.negativeTests, 'Pruebas negativas'),
                _cardDataItem(state.positiveTests, 'Pruebas Positivas'),
                _cardDataItem(state.deceased, 'Fallecidos'),
                _cardDataItem(state.recovered, 'Recuperados'),
                _cardDataItem(state.pendingTests, 'Pruebas pendientes'),
              ],
            ),
            const Spacer(),
            Text(
              "El proyecto COVID Tracking ha finalizado toda recopilación de datos a partir del 7 de marzo de 2021",
              style: arial.copyWith(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }

  Widget _cardDataItem(String title, String value) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      elevation: 0,
      color:
          themeProvider.isDarkMode() ? ThemeColors.darkGrey : ThemeColors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: menlo.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: menlo.copyWith(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Cerrar sesión"),
          content: const Text("¿Está seguro que desea cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, "/login");
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void _regions() {
    debugPrint("Regions");
  }
}

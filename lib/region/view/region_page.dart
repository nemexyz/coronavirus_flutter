import 'package:coronavirus/region/view/detail_card.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:coronavirus/region/region.dart';
import 'package:coronavirus/theme/colors.dart';
import 'package:coronavirus/theme/fontstyle.dart';
import 'package:coronavirus/theme/loading.dart';
import 'package:coronavirus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RegionPage extends StatelessWidget {
  static const String routeName = "/region";

  const RegionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)!.settings.arguments as String;
    return RepositoryProvider(
      create: (context) => CovidRepository(),
      child: BlocProvider(
        create: (context) => RegionBloc(
          repository: RepositoryProvider.of<CovidRepository>(context),
        )..add(LoadRegion(region: state)),
        child: const RegionView(),
      ),
    );
  }
}

class RegionView extends StatefulWidget {
  const RegionView({Key? key}) : super(key: key);

  @override
  State<RegionView> createState() => _RegionViewState();
}

class _RegionViewState extends State<RegionView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: null,
      backgroundColor:
          themeProvider.isDarkMode() ? ThemeColors.grey2 : ThemeColors.white,
      body: BlocConsumer<RegionBloc, RegionState>(
        listenWhen: (previous, current) =>
            current.status == RegionStatus.failure,
        listener: (_, state) {
          if (state.status == RegionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ThemeColors.primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == RegionStatus.loading) {
            return const CircularLoading();
          }
          return CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: themeProvider.isDarkMode()
                    ? ThemeColors.grey2
                    : ThemeColors.white,
                expandedHeight: height * 0.22,
                pinned: true,
                elevation: 8.0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsetsDirectional.only(
                    start: 0,
                    bottom: 16,
                  ),
                  centerTitle: true,
                  background: const VirusLoader(),
                  title: Text(
                    state.name,
                    style: arialbold.copyWith(
                        fontSize: 20,
                        color: themeProvider.isDarkMode()
                            ? ThemeColors.white
                            : ThemeColors.grey),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 20,
                  ),
                  shrinkWrap: true,
                  children: [
                    Column(children: <Widget>[
                      DetailCard(
                        title: "Casos totales",
                        subtitle: state.totalCases,
                        icon: Icons.masks,
                        iconColor: Colors.blue,
                      ),
                      DetailCard(
                        title: "Casos confirmados",
                        subtitle: state.confirmedCases,
                        icon: Icons.security,
                        iconColor: Colors.green,
                      ),
                      DetailCard(
                        title: "Pruebas negativas",
                        subtitle: state.negativeTests,
                        icon: Icons.person,
                        iconColor: Colors.red,
                      ),
                      DetailCard(
                        title: "Pruebas positivas",
                        subtitle: state.positiveTests,
                        icon: Icons.access_time,
                        iconColor: Colors.purple,
                      ),
                      DetailCard(
                        title: "Fallecidos",
                        subtitle: state.deceased,
                        icon: Icons.assignment,
                        iconColor: Colors.blue,
                      ),
                      DetailCard(
                        title: "Recuperados",
                        iconColor: Colors.red,
                        icon: Icons.airline_seat_individual_suite,
                        subtitle: state.recovered,
                      ),
                      DetailCard(
                        title: "Pruebas pendientes",
                        iconColor: Colors.green,
                        icon: Icons.security_update_good,
                        subtitle: state.pendingTests,
                      ),
                      DetailCard(
                        title: "Notas (en ingles)",
                        subtitle: state.notes,
                        icon: Icons.add_circle,
                        iconColor: Colors.deepOrange,
                        smallText: true,
                      ),
                    ]),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

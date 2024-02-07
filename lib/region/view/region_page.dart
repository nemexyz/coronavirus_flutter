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
    return RepositoryProvider(
      create: (context) => CovidRepository(),
      child: BlocProvider(
        create: (context) => RegionBloc(
          repository: RepositoryProvider.of<CovidRepository>(context),
        )..add(LoadRegion()),
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Nombre de la región"),
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: themeProvider.isDarkMode()
            ? ThemeColors.darkGrey
            : ThemeColors.white,
        shadowColor: ThemeColors.grey,
        elevation: 2,
      ),
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
          return const Center(child: Text("Region"));
        },
      ),
    );
  }
}

import 'package:coronavirus/region/view/region_page.dart';
import 'package:coronavirus/repository/covid_repository.dart';
import 'package:coronavirus/states/states.dart';
import 'package:coronavirus/theme/colors.dart';
import 'package:coronavirus/theme/fontstyle.dart';
import 'package:coronavirus/theme/loading.dart';
import 'package:coronavirus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class StatesPage extends StatelessWidget {
  static const String routeName = "/states";

  const StatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CovidRepository(),
      child: BlocProvider(
        create: (context) => StatesBloc(
          repository: RepositoryProvider.of<CovidRepository>(context),
        )..add(LoadStates()),
        child: const StatesView(),
      ),
    );
  }
}

class StatesView extends StatefulWidget {
  const StatesView({Key? key}) : super(key: key);

  @override
  State<StatesView> createState() => _StatesViewState();
}

class _StatesViewState extends State<StatesView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Detalles por región"),
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
      body: BlocConsumer<StatesBloc, StatesState>(
        listenWhen: (previous, current) =>
            current.status == StatesStatus.failure,
        listener: (_, state) {
          if (state.status == StatesStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ThemeColors.primaryColor,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == StatesStatus.loading) {
            return const CircularLoading();
          }
          if (state.states.isEmpty) {
            return const Center(
              child: Text("No hay datos disponibles"),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            itemCount: state.states.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              var item = state.states[index];
              return Card(
                elevation: 0,
                color: themeProvider.isDarkMode()
                    ? ThemeColors.darkGrey
                    : ThemeColors.white2,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: ThemeColors.grey, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ThemeColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: themeProvider.isDarkMode()
                                  ? ThemeColors.lightGrey
                                  : ThemeColors.grey,
                              blurRadius: 4,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            item.url,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              return progress == null
                                  ? child
                                  : const SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                        color: ThemeColors.grey,
                                      ),
                                    );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error_outline, size: 40);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  horizontalTitleGap: 12,
                  title: Text(
                    item.name,
                    style: arialbold.copyWith(fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Casos totales: ",
                            style: arialbold.copyWith(fontSize: 12),
                          ),
                          Text(
                            item.total,
                            style: arial.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        "Última modificación: ${item.modified}",
                        style: arial.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  trailing: Text(
                    String.fromCharCode(
                      Icons.arrow_forward_ios_rounded.codePoint,
                    ),
                    style: TextStyle(
                      color: themeProvider.isDarkMode()
                          ? ThemeColors.white
                          : ThemeColors.grey,
                      inherit: false,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      fontFamily: Icons.arrow_forward_ios_rounded.fontFamily,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      RegionPage.routeName,
                      arguments: item.state,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:look_lock_app/models/projected_alert.dart';
import 'package:look_lock_app/services/alert_services.dart';
import 'package:look_lock_app/services/storage_services.dart';
import 'package:look_lock_app/views/welcome_screen.dart';
import 'package:look_lock_app/widgets/alert_card.dart';
import 'package:look_lock_app/widgets/page_title.dart';
import 'package:look_lock_app/widgets/styled_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProjectedAlert>> _alerts;

  @override
  void initState() {
    super.initState();
    _alerts = AlertServices().fetchAlerts();
  }

  void _search() {}

  void _logOut() async {
    await StorageServices.clearToken();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text('Inicio',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.background,
                  )),
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          actions: [
            IconButton(onPressed: _search, icon: const Icon(Icons.search)),
            IconButton(
              onPressed: _logOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const PageTitle(
                  title: 'Resumen de alertas',
                  subtitle:
                      'En esta sección podrás ver un resumen de las alertas que se han generado en tu hogar.'),
              const SizedBox(
                height: 10,
              ),
              _filtersOptions(),
              const SizedBox(
                height: 5,
              ),
              _buildAlertsSection(),
              const SizedBox(
                height: 20,
              ),
              StyledButton(text: 'Ver todas', onPressed: () {})
            ],
          ),
        ));
  }

  Widget _filtersOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        StyledButton(
          text: 'Por fecha',
          onPressed: () {},
          fontSize: 12,
          horizontalPadding: 40,
          verticalPadding: 10,
        ),
        StyledButton(
          text: 'Por hora',
          onPressed: () {},
          fontSize: 12,
          horizontalPadding: 40,
          verticalPadding: 10,
        ),
      ],
    );
  }

  Widget _buildAlertsSection() {
    return FutureBuilder<List<ProjectedAlert>>(
      future: _alerts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return AlertCard(
                  title: snapshot.data![index].date,
                  subtitle: snapshot.data![index].time,
                  buttonText: 'Ver más',
                  buttonAction: () {},
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

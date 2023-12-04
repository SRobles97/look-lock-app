import 'package:flutter/material.dart';
import 'package:look_lock_app/models/projected_alert.dart';
import 'package:look_lock_app/services/alert_services.dart';
import 'package:look_lock_app/services/storage_services.dart';
import 'package:look_lock_app/views/logged/alert_details.dart';
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
  late Future<List<ProjectedAlert>> _displayedAlerts;
  String _selectedDate = '';
  String _selectedStartTime = '';
  String _selectedEndTime = '';

  @override
  void initState() {
    super.initState();
    setupAlerts();
  }

  void setupAlerts() async {
    _alerts = AlertServices().fetchProjectedAlerts();
    _displayedAlerts = _alerts;
  }

  void filterByDate() async {
    if (_selectedDate.isNotEmpty) {
      _displayedAlerts = AlertServices().fetchAlertsByDate(_selectedDate);
    }
  }

  void _search() {}

  void _logOut() async {
    await StorageServices.clearAll();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }

  void _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selectedDate != null) {
      String formattedDate =
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      setState(() {
        _selectedDate = formattedDate;
        print(formattedDate);
        filterByDate();
      });
    }
  }

  void _selectStartTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      String formattedTime = "${selectedTime.hour}:${selectedTime.minute}";
      setState(() {
        _selectedStartTime = formattedTime;
      });
    }
  }

  void _selectEndTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      String formattedTime = "${selectedTime.hour}:${selectedTime.minute}";
      setState(() {
        _selectedEndTime = formattedTime;
      });
    }
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
          onPressed: () => _selectDate(),
          fontSize: 12,
          horizontalPadding: 40,
          verticalPadding: 10,
        ),
        StyledButton(
          text: 'Por hora',
          onPressed: () {
            _selectStartTime();
            _selectEndTime();
          },
          fontSize: 12,
          horizontalPadding: 40,
          verticalPadding: 10,
        ),
      ],
    );
  }

  Widget _buildAlertsSection() {
    return FutureBuilder<List<ProjectedAlert>>(
      future: _displayedAlerts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text('No hay alertas para mostrar',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 10,
              ),
              Icon(
                Icons.hourglass_empty,
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
            ],
          );
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Center(
                  child: AlertCard(
                    title: snapshot.data![index].date,
                    subtitle: snapshot.data![index].time,
                    buttonText: 'Ver más',
                    buttonAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AlertDetails(alertId: snapshot.data![index].id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

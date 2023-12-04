import 'package:flutter/material.dart';
import 'package:look_lock_app/models/alert.dart';
import 'package:look_lock_app/services/alert_services.dart';

class AlertDetails extends StatefulWidget {
  final int alertId;

  const AlertDetails({Key? key, required this.alertId}) : super(key: key);

  @override
  State<AlertDetails> createState() => _AlertDetailsState();
}

class _AlertDetailsState extends State<AlertDetails> {
  late Future<Alert> _alert;

  @override
  void initState() {
    super.initState();
    _alert = AlertServices().fetchAlert(widget.alertId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: Column(
          children: <Widget>[
            FutureBuilder(
                future: _alert,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Alert alert = snapshot.data as Alert;
                    return Column(
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Image.network(
                                alert.imageTaken,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              color: Colors.black45,
                              child: Text(
                                'Individuo no autorizado',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'DETALLES',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Fotografía tomada el:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'Día: ${alert.date}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                ),
                                Text(
                                  'A las: ${alert.time} hrs.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ));
  }
}

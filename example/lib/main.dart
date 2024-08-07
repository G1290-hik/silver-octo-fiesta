import 'package:flutter/material.dart';
import 'package:health_example/src/service/health_service.dart';
import 'package:health_example/src/utils/util.dart';
import 'package:health_example/src/views/view.dart';

void main() => runApp(HealthApp());

class HealthApp extends StatefulWidget {
  @override
  _HealthAppState createState() => _HealthAppState();
}

class _HealthAppState extends State<HealthApp> {
  final HealthService _healthService = HealthService();
  AppState _state = AppState.DATA_NOT_FETCHED;

  @override
  void initState() {
    super.initState();
    _healthService.configureHealth();
    authorize();
  }

  Future<void> authorize() async {
    bool authorized = await _healthService.authorize();
    setState(() =>
        _state = authorized ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: _state == AppState.DATA_NOT_FETCHED
              ? SplashScreen()
              : (_state == AppState.AUTHORIZED
                  ? MainView()
                  : AuthorizationScreen())),
    );
  }
}

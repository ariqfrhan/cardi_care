import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetControllerWidget extends StatefulWidget {
  final Widget Function(BuildContext context, bool isConnected) builder;

  const InternetControllerWidget({Key? key, required this.builder})
      : super(key: key);

  @override
  _InternetControllerWidgetState createState() =>
      _InternetControllerWidgetState();
}

class _InternetControllerWidgetState extends State<InternetControllerWidget> {
  bool _isConnected = false;
  late StreamSubscription<InternetStatus> _internetSubscription;

  @override
  void initState() {
    super.initState();
    _internetSubscription =
        InternetConnection().onStatusChange.listen((status) {
      setState(() {
        _isConnected = status == InternetStatus.connected;
      });
    });
  }

  @override
  void dispose() {
    _internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _isConnected);
  }
}

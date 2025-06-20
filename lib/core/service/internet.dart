import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetBannerWrapper extends StatefulWidget {
  final Widget child;

  const InternetBannerWrapper({super.key, required this.child});

  @override
  State<InternetBannerWrapper> createState() => _InternetBannerWrapperState();
}

class _InternetBannerWrapperState extends State<InternetBannerWrapper> {
  bool _isOffline = false;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void initState() {
    super.initState();
    _checkConnection(); // أول فحص عند التشغيل

    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final result = results.first; // ناخد أول نتيجة
      _checkConnectionFrom(result);
    });
  }

  Future<void> _checkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _checkConnectionFrom(connectivityResult as ConnectivityResult);
  }

  Future<void> _checkConnectionFrom(ConnectivityResult connectivityResult) async {

    if (connectivityResult == ConnectivityResult.none) {
      _setOffline(true);
    } else {
      try {
        final result = await InternetAddress.lookup('example.com')
            .timeout(const Duration(seconds: 3));
        final hasConnection =
            result.isNotEmpty && result[0].rawAddress.isNotEmpty;
        _setOffline(!hasConnection);
      } catch (_) {
        _setOffline(true);
      }
    }
  }

  void _setOffline(bool offline) {
    if (_isOffline != offline) {
      setState(() {
        _isOffline = offline;
      });
      print('Actual isOffline: $_isOffline');
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedSlide(
            offset: _isOffline ? const Offset(0, 0) : const Offset(0, 1),
            duration: const Duration(milliseconds: 300),
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'No Internet Connection',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

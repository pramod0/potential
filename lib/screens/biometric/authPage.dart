import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/authVerifier.dart';
import '../splash.dart';

class AuthPage extends ConsumerStatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage>
    with WidgetsBindingObserver {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-authenticate when the app comes back to the foreground
      _reAuthenticateIfNeeded();
    }
  }

  Future<void> _reAuthenticateIfNeeded() async {
    bool isAuthenticated = await _authService.authenticateWithBiometrics();
    if (!isAuthenticated) {
      // Show an error or take necessary action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Re-authentication failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Authentication')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            bool isAuthenticated =
                await _authService.authenticateWithBiometrics();
            if (isAuthenticated) {
              // Navigate to the next screen
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Splash()));
            } else {
              // Show an error message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Authentication failed')),
              );
            }
          },
          child: const Text('Authenticate'),
        ),
      ),
    );
  }
}

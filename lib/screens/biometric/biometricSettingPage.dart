import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/biometric_auth_state.dart';

class BiometricSettingsPage extends ConsumerStatefulWidget {
  const BiometricSettingsPage({Key? key}) : super(key: key);

  @override
  _BiometricSettingsPageState createState() => _BiometricSettingsPageState();
}

class _BiometricSettingsPageState extends ConsumerState<BiometricSettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final biometricDetails = ref.watch(biometricProvider);
// Listening to changes without rebuilding the UI

    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Enable Biometrics'),
              value: biometricDetails.biometricOn,
              onChanged: (bool value) {
                ref.listen<BiometricDetails>(biometricProvider,
                    (previous, next) {
                  if (next.biometricOn) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Biometric Authentication Enabled')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Biometric Authentication Disabled')),
                    );
                  }
                });
                BiometricDetails().saveSettings(
                  isBiometricOn: value,
                  isFaceOn: biometricDetails.faceOn,
                  isFingerPrintOn: biometricDetails.fingerPrintOn,
                  isUserConsentToBioMetric:
                      biometricDetails.userConsentToBioMetric,
                );
              },
            ),
            SwitchListTile(
              title: const Text('Enable Face Recognition'),
              value: biometricDetails.faceOn,
              onChanged: biometricDetails.biometricOn
                  ? (bool value) {
                      ref.read(biometricProvider).saveSettings(
                            isBiometricOn: biometricDetails.biometricOn,
                            isFaceOn: value,
                            isFingerPrintOn: biometricDetails.fingerPrintOn,
                            isUserConsentToBioMetric:
                                biometricDetails.userConsentToBioMetric,
                          );
                    }
                  : null,
            ),
            SwitchListTile(
              title: const Text('Enable Fingerprint'),
              value: biometricDetails.fingerPrintOn,
              onChanged: biometricDetails.biometricOn
                  ? (bool value) {
                      ref.read(biometricProvider).saveSettings(
                            isBiometricOn: biometricDetails.biometricOn,
                            isFaceOn: biometricDetails.faceOn,
                            isFingerPrintOn: value,
                            isUserConsentToBioMetric:
                                biometricDetails.userConsentToBioMetric,
                          );
                    }
                  : null,
            ),
            SwitchListTile(
              title: const Text('Consent to Use Biometrics'),
              value: biometricDetails.userConsentToBioMetric,
              onChanged: (bool value) {
                ref.read(biometricProvider).saveSettings(
                      isBiometricOn: biometricDetails.biometricOn,
                      isFaceOn: biometricDetails.faceOn,
                      isFingerPrintOn: biometricDetails.fingerPrintOn,
                      isUserConsentToBioMetric: value,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

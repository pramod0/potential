import 'package:flutter/material.dart';
import 'package:potential/utils/AllData.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile picture
                const CircleAvatar(
                  radius: 50.0,
                  child: Icon(
                    Icons.person_rounded,
                    size: 35,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Username
                Text(
                  "${AllData.investorData.firstName ?? ""} ${AllData.investorData.lastName ?? ""}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10.0),
                // Bio
                Text(
                  AllData.investorData.email ?? "",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4.0),
                // Bio
                Text(
                  AllData.investorData.phoneNumber ?? "",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                // Bio
                Text(
                  AllData.investorData.panCard ?? "",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                // Bio
                const Text(
                  "Every century starts with a zero",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                // Edit profile button
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to edit profile page or handle click
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.arrow_back),
                        const Text('Back'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

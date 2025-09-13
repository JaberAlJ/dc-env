import 'package:dc_env/core/constants.dart';
import 'package:dc_env/pages/main_page.dart';
import 'package:dc_env/pages/registration_page.dart';
import 'package:dc_env/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'change_notifiers/documents_provider.dart';
import 'change_notifiers/registration_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DocumentsProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationController()),
      ],
      child: MaterialApp(
        title: 'Document Creation Environment',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: background,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: background,
            titleTextStyle: const TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, snapshot) {
            // TODO: Make a way for the users that are registered by the admin to pass to the MainPage, because there emails are not verified
            return snapshot.hasData && AuthService.isEmailVerified
                ? const MainPage()
                : const RegistrationPage();
          },
        ),
      ),
    );
  }
}
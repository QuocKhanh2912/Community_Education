import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pikachu_education/pages/authentication/login_page/bloc/login_page/login_bloc.dart';
import 'package:pikachu_education/pages/splash_page/splash_page.dart';
import 'package:pikachu_education/routes/route_management.dart';
import 'package:pikachu_education/utils/observing_blog.dart';
import 'domain/services_config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        localizationsDelegates: const [FormBuilderLocalizations.delegate],
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

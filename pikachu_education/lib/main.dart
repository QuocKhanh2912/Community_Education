import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pikachu_education/pages/authentication/login_page/bloc/login_page/login_bloc.dart';
import 'package:pikachu_education/pages/splash_page/splash_page.dart';
import 'package:pikachu_education/routes/route_management.dart';
import 'package:pikachu_education/utils/l10n/l10n.dart';
import 'package:pikachu_education/utils/observing_blog.dart';
import 'bloc/internationalization_bloc.dart';
import 'domain/services_config/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => InternationalizationBloc()..add(InternationalizationInitEvent()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<InternationalizationBloc, InternationalizationState>(
            builder: (context, state) {

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                supportedLocales: L10n.all,
                locale: state.appLangCode==null?null:Locale(state.appLangCode??'en'),
                home: const SplashPage(),
                localizationsDelegates: const [
                  FormBuilderLocalizations.delegate,
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                onGenerateRoute: generateRoute,
              );
            },
          );
        }
      ),
    );
  }
}

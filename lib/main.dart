import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc/bloc.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/cubit/bloc_observer.dart';
import 'package:m_wallet_hps/network/remote/dio_helper.dart';
import 'package:m_wallet_hps/screens/AcccueilScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:m_wallet_hps/screens/home_page.dart';
import 'package:m_wallet_hps/screens/login_page.dart';
import 'package:m_wallet_hps/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'network/local/cache_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Firebase.initializeApp();
  String? token;
  Widget widget;
  try {
    token = CacheHelper.getData(key: 'token');
  } catch (e) {
    print(e);
  }
  print('token is ');
  print(token);

  if (token == null) {
    widget = const LoginPage();
  } else if (jwtVerification(token) == true) {
    print(jwtVerification(token));
    widget = const HomePage();
  } else {
    widget = const LoginPage();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.startWidget});
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AppCubit()
                ..loadLoggedInUser(CacheHelper.getData(key: 'email'),
                    CacheHelper.getData(key: 'swift'))),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: AnimatedSplashScreen(
              splashIconSize: 500,
              nextScreen: startWidget,
              backgroundColor: Colors.white,
              splashTransition: SplashTransition.fadeTransition,
              duration: 3000,
              splash: Center(
                child: Column(

                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/Payit.png'),
                        ),
                      ),
                    ),
                    TyperAnimatedTextKit(
                      text: const ["Discover The Future \n With US..."],
                      textStyle: GoogleFonts.fredokaOne(
                        textStyle:
                            TextStyle(fontSize: 25, color: Color(0xff4c6611)),
                      ),
                      textAlign: TextAlign.center,
                      speed: Duration(milliseconds: 100),
                    ),
                    Spacer(),
                    CircularProgressIndicator(backgroundColor: Colors.green,color: Color(0xff4c6611)),
                  ],
                ),
              ),
            ),
            routes: {
              SignupPage.id: (context) => SignupPage(),
              LoginPage.id: (context) => const LoginPage(),
              // HomePage.id: (context) => const HomePage(),

              AcccueilScreen.id: (context) => AcccueilScreen(),
            },
          ),
        ));
  }
}

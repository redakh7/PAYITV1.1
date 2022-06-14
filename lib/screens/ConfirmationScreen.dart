import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(ConfitmationScreen());

class ConfitmationScreen extends StatefulWidget {
  const ConfitmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfitmationScreen> createState() => _ConfitmationScreenState();
}

class _ConfitmationScreenState extends State<ConfitmationScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.blue),
            leading: IconButton(
              icon: const Icon(
                Icons.navigate_before,
                size: 40,
              ),
              onPressed: () {}
            ),
          ),
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('images/emailsend.png'),
                )),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'Confirm your email address',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Text(
                'We sent a confirmation email to  ',
                style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: Colors.blueGrey),
              ),
              SizedBox(
                height: 13,
              ),
              Text(
                'test@gmail.com ',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Text(
                'check your email and click on the \n      confirmation link to continue. ',
                style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: Colors.blueGrey),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/network/local/cache_helper.dart';
import 'package:m_wallet_hps/screens/AcccueilScreen.dart';
import 'package:m_wallet_hps/screens/accueilScreen.dart';
import 'package:m_wallet_hps/screens/home_page.dart';
import 'package:m_wallet_hps/screens/signup_page.dart';
import 'package:m_wallet_hps/shared/buttons.dart';
import 'package:m_wallet_hps/shared/component.dart';

class LoginPage extends StatefulWidget {
  static String id = "LoginScreen";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var usernameLoginController = TextEditingController();
  var passwordLogController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) async {
      if (state is AppLoginSuccessStates) {
        String? token = await FirebaseMessaging.instance.getToken();
        CacheHelper.saveData(key: 'swift', value:AppCubit.get(context).element.toLowerCase() );
          AppCubit.get(context).addTokenToUser(AppCubit.get(context).userModel?.data.email,token, CacheHelper.getData(key: 'swift'));
        CacheHelper.saveData(key: 'token', value: state.userModel.token);
        CacheHelper.saveData(key: 'email', value: state.userModel.data.email);


        showToast(message: state.userModel.message);
        navigateAndFinish(context, HomePage());
      } else if (state is AppLoginErrorStates) {
        showToast(message: state.error);
      }
    }, builder: (context, state) {
      return Container(

        child: Form(
          key: _formKey,
          child: Scaffold(

            backgroundColor: Colors.white,
            body: ListView(
              padding: EdgeInsets.only(left: 55, right: 55, top: 120),
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: EdgeInsets.only(top: 40),
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/Payit.png')
                                )
                            ),
                          ),
                          Text("ayit",style:TextStyle(fontSize: 60,)),

                        ],
                      ),

                    ),
                     Container(
                       margin: EdgeInsets.only(top: 70),
                       child: TextFormField(
                         validator: (value)  {
                           if (value!.isEmpty) {
                             return "the Username must not be empty";
                           }
                           return null;
                         },
                         controller: usernameLoginController,
                         textAlign: TextAlign.center,
                         style: GoogleFonts.manrope(
                           fontWeight: FontWeight.w400,
                           fontSize: 14,
                         ),
                         decoration: InputDecoration(
                           hintText: 'Enter your username',
                           fillColor:  Color(0xff243656),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20),
                             borderSide: const BorderSide(color: Colors.green, width: 2.0),
                           ),
                           focusedBorder:  OutlineInputBorder(
                             borderRadius: BorderRadius.circular(20),

                             borderSide: const BorderSide(color: Colors.green, width: 2.0),
                           ),
                         ),
                       ),
                     ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 30),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "the Password must not be empty";
                          }
                          return null;
                        },
                        controller: passwordLogController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          fillColor:  Color(0xff243656),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),

                            borderSide: const BorderSide(color: Colors.green, width: 2.0),
                          ),
                        ),
                      ),

                    ),
                    Row(
                      children: [
                        Padding(
                          //padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                          "Choose Bank",
                          style: TextStyle(color: Color(0xff243656)),
                      ),
                        ),

                 Container(width: 62,),
                        DropdownButton(alignment: Alignment.topCenter,
                            elevation: 2,

                            style:const TextStyle(color:Color(0xff243656),),
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            dropdownColor: Colors.white,

                            value: AppCubit.get(context).element,
                            items: AppCubit.banks
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(

                                value: value,
                                child: Text(value.toUpperCase(),style: TextStyle(
                                    color: Color(0xff243656),
                                ),),
                              );
                            }).toList(),
                            onChanged: (value) {
                              AppCubit.get(context).changeBank(value);
                            }),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff1546A0).withOpacity(0.5),
                            offset: Offset(0, 24),
                            blurRadius: 50,
                            spreadRadius: -18,
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(usernameLoginController.text);
                            print(passwordLogController.text);
                            AppCubit.get(context).userLogin(
                                swift: AppCubit.get(context)
                                    .element
                                    .toLowerCase(),
                                username: usernameLoginController.text,
                                password:
                                passwordLogController.text);
                          }
                        },
                        textColor: Color(0xffFFFFFF),
                        padding: EdgeInsets.all(0),
                        shape: StadiumBorder(),
                        child: Container(
                          width:  275,
                          height: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.green,
                                Color(0xff1546A0),
                              ],
                            ),
                          ),
                          child: Text(
                            'Log in',
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 65),
                      child: Text(
                        'Not a member ?',
                        style: GoogleFonts.manrope(
                          color: Color(0xff1546A0).withOpacity(0.5),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 28),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffF5F7FA),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: 0,
                        width: 65,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 22, bottom: 22),
                      child: TextButton(
                        onPressed: () {
                          navigateAndFinish(context, SignupPage());
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                          ),
                        ),
                      )
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      );
    });
  }
}

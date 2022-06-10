import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

        child: Scaffold(

          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              "Choose Bank",
              style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: DropdownButton(alignment: Alignment.topCenter,
                    icon: Icon(Icons.account_balance_outlined,color: Colors.green,),
                  elevation: 2,

                    style:const TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                   borderRadius: const BorderRadius.all(Radius.circular(20)),
                      dropdownColor: Colors.white,

                      value: AppCubit.get(context).element,
                      items: AppCubit.banks
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(

                          value: value,
                          child: Text(value.toUpperCase(),style: TextStyle(
                            color: Colors.green
                          ),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        AppCubit.get(context).changeBank(value);
                      }),
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children:  [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/Payit.png')
                                )
                            ),
                          ),
                          Text("Payit",style:TextStyle(fontSize: 70,fontWeight: FontWeight.bold)),
                          Text(".",style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold,color: Color(0xff86B61B)), )
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            top: 65.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "the Username must not be empty";
                                }
                                return null;
                              },
                              controller: usernameLoginController,
                              decoration: const InputDecoration(
                                  labelText: 'USERNAME',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            const SizedBox(height: 30.0),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "the Password  must not be empty";
                                }
                                return null;
                              },
                              controller: passwordLogController,
                              decoration: const InputDecoration(
                                  labelText: 'PASSWORD   ',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: const Alignment(1.0, 0.0),
                              padding: const EdgeInsets.only(
                                  top: 15.0, left: 20.0),
                              child: const InkWell(
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            SizedBox(
                              height: 40.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.green,
                                elevation: 7.0,
                                child: Center(
                                    child: loginButton(
                                  buttonText: "Login",
                                  function: () {
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
                                )),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              height: 40.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(20.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Center(
                                        // child: ImageIcon(AssetImage('assets/66436-play-google-icons-computer-email-gmail.png')),
                                        ),
                                    Center(
                                      child: Text(
                                        'Log in With Gmail',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'New here ?',
                          style: TextStyle(fontFamily: 'Montserrat'),
                        ),
                        const SizedBox(width: 5.0),
                        TextButton(
                          onPressed: () {
                            navigateAndFinish(context, SignupPage());
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/models/userModel.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserModel? userModel = AppCubit.get(context).userModel;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
          child: Column(
            children: [
              Container(

                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(180)),
          gradient: LinearGradient(
          colors: [
            Color(0xff4889aa),
            Color(0xff4889aa),
            Color(0xff4c91bc),
            Color(0xff4c91bc),

          ],
                )),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [

                      const SizedBox(
                        height: 22,
                      ),
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/profile.png"),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [


                    Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Color(0xff4c91bc),width: 2 ),
                        color: Colors.white,

                      ),
                      child: Column(
                        children: [
                          RowBuilder(
                              att: "Full Name :",
                              text:
                              "${userModel?.data.firstName} ${userModel?.data.lastName}"),
                          const Divider(
                            color: Colors.black,
                            endIndent: 100,
                            indent: 100,
                          ),
                          RowBuilder(
                              att: "Rib :",
                              text: "${userModel?.data.rib}"),
                          const Divider(
                            color: Colors.black,
                            endIndent: 100,
                            indent: 100,
                          ),
                          RowBuilder(
                              att: "Email :",
                              text: "${userModel?.data.email}"),
                          const Divider(
                            color: Colors.black,
                            endIndent: 100,
                            indent: 100,
                          ),
                          RowBuilder(
                              att: "Solde :",
                              text: "${userModel?.data.solde} MAD"),
                          const Divider(
                            color: Colors.black,
                            endIndent: 100,
                            indent: 100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                color: Color(0xff4c91bc),
                  height: 40,

                  onPressed: (){
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                      ),
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[

                               Text("SCAN ME !",style: TextStyle(color: Colors.green,fontSize: 20),),
                                SizedBox(height: 10,),
                              QrImage(data: "${AppCubit.get(context).userModel?.data.rib}",

                              size: 200,
                              ) ,
                              ],
                            ),
                          );
                        });

                  },
                  child: Container(
                    width: 120,

                    child: Row(
    children: const [
                Text("QR CODE",style: TextStyle(color:Colors.white),),
             Spacer(),
             Icon(Icons.qr_code_scanner,color: Colors.white,),
    ],
    ),
                  ),
              )],
          ),
        ));
  }
}

Widget RowBuilder({
  required String text,
  required String att,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            att,
            style: const TextStyle(
                color:  Color(0xff4c91bc),
                fontFamily: 'Nunito',
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xff4c6611),
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );

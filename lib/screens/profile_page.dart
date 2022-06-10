import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/models/userModel.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserModel? userModel = AppCubit.get(context).userModel;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                )
              ],
            ),
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

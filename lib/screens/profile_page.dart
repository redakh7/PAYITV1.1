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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  const Text(
                    'My Profile',

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color(0xff4c6611),
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Column(
                    children: [
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
                      Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color:Color(0xff4c6611) ),
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
                  )
                ],
              ),
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
                color: Color(0xff4c6611),
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
            ),
          ),
        ],
      ),
    );

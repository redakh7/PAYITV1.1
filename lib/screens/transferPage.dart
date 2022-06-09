import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';

import 'package:m_wallet_hps/screens/home_page.dart';
import 'package:m_wallet_hps/shared/component.dart';


import '../cubit/app_cubit.dart';


class FirstRoute extends StatelessWidget {
   FirstRoute({key});
   var montantController = TextEditingController();
   var destinataireController = TextEditingController();
   var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>( listener: (context,state){
      if(state is LoadLoggedInUserSuccess){
        navigateAndFinish(context,HomePage());
        AppCubit.get(context).currentIndex=0;
      }
    },builder: (context,state){
      return Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage('images/body_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomSheet: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(

                        fontSize: 18,
                      ),
                      decoration:  InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),

                        fillColor: Colors.white,
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        //add prefix icon

                        hintStyle: const TextStyle(

                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        //create lable
                        labelText: '  Motif',
                        //lable style
                        labelStyle: TextStyle(

                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: (){
                        print(destinataireController.text);
                        print(montantController.text);
                        print(messageController.text);
                        String emetteur = AppCubit.get(context).userModel!.data.rib;

                        showMyDialog(context: context,destinataireController: destinataireController.text,montantController: montantController.text,messageController: messageController.text,emetteur: emetteur);
                      },
                      child: Ink(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: const Text('SEND',style: TextStyle(color: Colors.white),),alignment: Alignment.center,),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.green),
            title: const Text(
              'VIREMENT',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green, fontSize: 25),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: montantController,
                        keyboardType: TextInputType.number,
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "0,00 MAD",
                        ),
                      ),
                      const    SizedBox(
                        height: 10,
                      ),
                      TextDropdownFormField(
                        options: [
                          "MONSIEUR REDA KHOUDRI\n 234587643584559847",
                          "MONSIEUR REDA KHOUDRI\n YZTRYSGFHGH",
                        ],
                        decoration:const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            labelText: "Compte Source"),
                        dropdownHeight: 120,
                      ),
                      const  SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: destinataireController,
                        style:const  TextStyle(
                          fontSize: 18,

                        ),
                        decoration: const InputDecoration(
                          focusColor: Colors.white,
                          //add prefix icon
                          fillColor: Colors.grey,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),

                          //create lable
                          labelText: 'Compte Destinataire',
                          //lable style
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const     SizedBox(
                        height: 15,
                      ),
                      const  SizedBox(
                        height: 100,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                TextFormField(
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "0,00 MAD"),
                ),
                SizedBox(
                  height: 115,
                ),
                Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // Background color
                          onPrimary:
                              Colors.white, // Text Color (Foreground color)
                        ),
                        child: const Text('Go back!'),
                      ),
                      SizedBox(
                        width: 155,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // Background color
                          onPrimary:
                              Colors.white, // Text Color (Foreground color)
                        ),
                        child: const Text('Send Money'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
*
* TextFormField(
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        //add prefix icon
                        fillColor: Colors.grey,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                        labelText: 'Motif',
                        //lable style
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
* */

import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:m_wallet_hps/cubit/app_cubit.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/network/local/cache_helper.dart';
import 'package:m_wallet_hps/screens/settings_page.dart';
import 'package:m_wallet_hps/shared/buttons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomePage extends StatelessWidget {
  static String id = "HomeScreen";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {

      }),
      builder: ((context, state){
        return Conditional.single(context: context,
        conditionBuilder: (context)=>AppCubit.get(context).userModel!=null,
    widgetBuilder: (context)=> builderWidget(context),
    fallbackBuilder: (context) => Container(
      color: Colors.white,
      child: const Center(
      child: CircularProgressIndicator(backgroundColor: Colors.green,color: Colors.red),
      ),
    ));
    }
      ));
  }



  Widget builderWidget(context)=>Scaffold(
  backgroundColor: Colors.white,

    body: AppCubit.get(context)
        .bottomScreens[AppCubit.get(context).currentIndex],
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: SalomonBottomBar(
        currentIndex: AppCubit.get(context).currentIndex,
        onTap: (index) {
          AppCubit.get(context).changeBottom(index);
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.green,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: ImageIcon(AssetImage("asset/images/sendMoney.png")),
            title: Text("Search"),
            selectedColor: Colors.green,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.green,
          ),
        ],
      ),
    ),
  );
}

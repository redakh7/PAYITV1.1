import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:m_wallet_hps/cubit/app_states.dart';
import 'package:m_wallet_hps/models/userModel.dart';
import 'package:m_wallet_hps/network/local/cache_helper.dart';
import 'package:m_wallet_hps/network/remote/dio_helper.dart';
import 'package:m_wallet_hps/screens/profile_page.dart';
import 'package:m_wallet_hps/screens/transferPage.dart';
import '../screens/AcccueilScreen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  String? email;
  String? username;
  String? password;


  int currentIndex = 0;
  List<Widget> bottomScreens = [
    AcccueilScreen(),
     FirstRoute(),
     ProfilePage(),
  ];
  static List<String> banks = <String>['cih', 'attijari', 'sgma'];
  String element = banks.first;
  void changeBank(newvalue) {
    element = newvalue;
    emit(AppChangeBottomNavStates());
  }

  void changeBottom(index) {
    currentIndex = index;
    emit(AppChangeBottomNavStates());
  }

  UserModel? userModel;
  void userLogin(
      {required String username,
      required String password,
      required String swift}) {
print(username);
print(swift);
print(password);

    emit(AppLoginInitialStates());
    DioHelper.postDataLogins(
      url: "login?swift=$swift",
      data: {
        'username': username,
        'password': password,
      },
    ).then((value) {
        print(value.data);
      userModel = UserModel.fromJson(value.data);
      emit(AppLoginSuccessStates(userModel!));
      emit(LoginSaveTokenInitialStates());
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorStates("Login Failed"));
    });
  }

  void userSignUp(
      {required String swift,
      required String email,
      required String username,
      required String password,
      required String firstName,
      required String lastName}) {
    emit(AppSigninInitialStates());

    DioHelper.postData(
      url: "registration?swift=$swift",
      data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'username' : username
      },
    ).then((value) {
      emit(AppSigninSuccessStates(swift));

    }).catchError((error) {

      emit(AppSigninErrorStates(error.toString()));
    });
  }

  void addTokenToUser(email, deviceToken, swift) {
    emit(LoginSaveTokenInitialStates());

    DioHelper.postDataLogins(
            url: "fcm_token?swift=$swift",
            data: {"email": email, "fcmToken": deviceToken})
        .then((value) => {

              emit(LoginSaveTokenSuccessStates()),
            })
        .catchError((error) {
      emit(LoginSaveTokenErrorStates());

    });
  }

  void loadLoggedInUser(email, swift) {
    if (email != null) {
      emit(LoadLoggedInUserInitial());

      DioHelper.getData(url: "user?swift=$swift&email=$email").then((value) {
        userModel = UserModel.fromJson(value.data);

        emit(LoadLoggedInUserSuccess());
      }).catchError((error) {
        emit(LoadLoggedInUserError());

      });
    }
  }
  void Makevirement(montant,destinataire,message,emetteur){


    String operation_type = "virement";
    emit(AppVirementInitialStates());
    DioHelper.postData(url: "transfer/operation", data: {
      "operation_type" : operation_type,
      "montant" : montant,
      "emetteur" : emetteur,
      "destinataire" : destinataire,
      "message" : message
    }).then((value) {
      loadLoggedInUser(CacheHelper.getData(key: 'email'),CacheHelper.getData(key: 'swift'));
      emit(AppVirementSuccessStates());

    }).catchError((error){
      emit(AppVirementErrorStates());

    });
  }
}



bool jwtVerification(String token) {
  DateTime? expiryDate = Jwt.getExpiryDate(token);

  DateTime now = DateTime.now();
  if (expiryDate!.compareTo(now) < 0) {
    return true;
  } else {
    return true;
  }




}

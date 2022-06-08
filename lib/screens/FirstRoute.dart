import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';



class FirstRoute extends StatelessWidget {
  const FirstRoute({key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Center(

        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(

            children: [
              SizedBox(height: 150,),
              TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.grey,
                  ),



                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.green, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,

                  hintText: "Enter RIB here",

                  //make hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),

                  //create lable
                  labelText: 'RIB',
                  //lable style
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(

                style: TextStyle(
                  fontSize: 18,

                ),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  prefixIcon: Icon(
                    Icons.message,
                    color: Colors.grey,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.green, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,

                  hintText: "Enter Message here",

                  //make hint text
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
              ElevatedButton(
                  child: const Text('Continue'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondRoute()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Background color
                    onPrimary: Colors.white, // Text Color (Foreground color)
                  )
              ),
            ],
          ),
        ),
      ),
    );
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
              SizedBox(height: 200,),

              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 18,

                ),
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  //add prefix icon
                  prefixIcon: Icon(
                    Icons.monetization_on_sharp,
                    color: Colors.grey,
                  ),


                  fillColor: Colors.grey,

                  hintText: "0.00",

                  //make hint text
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),

                  //create lable

                  //lable style
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Center(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Background color
                        onPrimary: Colors.white, // Text Color (Foreground color)
                      ),
                      child: const Text('Go back!'),
                    ),
                    SizedBox(width: 155,),
                    ElevatedButton(
                      onPressed: () {
                      },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // Background color
                          onPrimary: Colors.white, // Text Color (Foreground color)
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
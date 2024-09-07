import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool isLoading  = true;
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 60,
          child:  const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                 Text('Loading...', style: TextStyle(fontSize: 20
                 ,fontWeight: FontWeight.bold),),
                 SizedBox(width: 10,),
                  CircularProgressIndicator(color: Colors.white,),
                ],
          )
              
              
              )
          ],
        ),
      )
    );
  }}

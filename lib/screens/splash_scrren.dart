import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                //gradiente de blanco a morado emieza desde arriba y termina abajo
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.white,
                  Colors.purple,
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/pair.png', fit: BoxFit.fill),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(250, 50),
                    //sombras
                    elevation: 10,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/game');
                  },
                  child: const Text(
                    'Jugar',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text('Desarrollado por Baneste Codes',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold))
              ],
            )));
  }
}

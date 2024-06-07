import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 120.0), // Espacio superior
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_fondo_blanco.jpg', // Ruta de la imagen
                  width: 150.0, // Ancho de la imagen
                  height: 150.0, // Alto de la imagen
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pollos Canallas',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Los Pollos de Nuevo León',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 63, 84),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0), // Espacio entre el subtítulo y los campos de entrada
            const Divider(
              color: Color.fromARGB(255, 255, 63, 84),
              thickness: 4,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(
                child: Text(
                  'Estas en tu casa',
                  style: TextStyle(fontSize: 30, fontFamily: "Rye"),
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 255, 63, 84),
              thickness: 4,
            ),
            const SizedBox(height: 120.0), // Espacio superior
            Container(
              width: 200,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 63, 84),
              ),
              child: TextButton(
                  child: const Text("Iniciar sesion", //Boton de iniciar sesion
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),),
                  onPressed: (){
                    Navigator.pushNamed(context, '/login');
                  }  //a donde deberia mandar el boton iniciar sesion
              ),
            ),
            const SizedBox(height: 60),
            Container(
                width: 200,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 63, 84),
                ),
                child: TextButton(
                    child: const Text("Registrarse",  //Boton crear cuenta
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),),
                    onPressed: (){
                      Navigator.pushNamed(context, '/signup');
                    }   //A donde deberia llevar el boton Crear Cuenta
                )
            )
          ],
        )
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polloscanallas/utils_widgets/form_container_widget.dart';
import 'package:polloscanallas/utils_widgets/redbutton_widget.dart';

import '../services/user_auth/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30.0), // Espacio superior
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
              const SizedBox(
                  height:
                      5.0), // Espacio entre el subtítulo y los campos de entrada
              const Divider(
                color: Color.fromARGB(255, 255, 63, 84),
                thickness: 4,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 30, fontFamily: "Rye"),
                  ),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 255, 63, 84),
                thickness: 4,
              ),
              const SizedBox(
                  height:
                      30.0), // Espacio entre el título y los campos de entrada
              // Aquí puedes agregar los campos de entrada de usuario y contraseña
              FormContainerWidget(
                controller: _emailController,
                hintText: "Correo Electronico",
                isPasswordField: false, isNumberOnly: false,
              ),
              const SizedBox(height: 20.0),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Contraseña",
                isPasswordField: true, isNumberOnly: false,
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 0, 40),
                child: RedButtonWidget(text: 'Iniciar Sesion', function: _signIn,)
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Divider(
                    color: Color.fromARGB(255, 255, 63, 84),
                    thickness: 4,
                  ),
                  const Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navegar a una ruta nombrada cuando se presiona el botón
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;


    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successflly signedIn");
      Navigator.pushNamed(context, '/listproducts');
    } else {
      print("Some error happend");
    }
  }


}

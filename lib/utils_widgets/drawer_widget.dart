import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 255, 63, 84),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          Image.asset(
            "assets/images/logo_fondo_rojo.png", // Reemplaza con la ruta de la imagen de tu logo
            width: 100.0, // Ajusta el ancho según sea necesario
            height: 100.0, // Ajusta la altura según sea necesario
          ),
          ListTile(
            title: const Center(
              child: Text("Productos",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/listproducts');
            },
          ),
          ListTile(
            title: const Center(
              child: Text(
                "Insumos",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/listsupplies');
            },
          ),
          ListTile(
            title: const Center(
              child: Text(
                "Proveedores",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/listsuppliers');
            },
          ),
          ListTile(
            title: const Center(
              child: Text(
                "Sucursales",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/listbranches');
            },
          ),
          ListTile(
            title: const Center(
              child: Text(
                "Reabastecimiento",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/resupply');
            },
          ),
          const Divider(
              thickness: 1.0), // Agrega un divisor para la separación visual
          SizedBox(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  title: const Text(
                    "Cerrar Sesion",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ))
        ],
      ),
    );
  }
}

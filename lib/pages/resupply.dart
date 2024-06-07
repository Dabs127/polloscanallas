import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polloscanallas/services/resupplies_services.dart';
import 'package:polloscanallas/utils_widgets/resupply_card_widget.dart';

import '../utils_widgets/appbar_widget.dart';
import '../utils_widgets/drawer_widget.dart';

class ResupplyPage extends StatefulWidget {
  const ResupplyPage({super.key});

  @override
  State<ResupplyPage> createState() => _ResupplyPageState();
}

class _ResupplyPageState extends State<ResupplyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0,),
              const Divider(color: Colors.redAccent, thickness: 4,),
          
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                  child: Text(
                      'Reabastecimientos',
                    style: TextStyle(fontSize: 30, fontFamily: "Rye"),
                  ),
                ),
              ),
          
              const Divider(color: Colors.redAccent, thickness: 4),
          
              const SizedBox(height:30.0), // Espacio entre el título y los campos de entrada
          
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 200,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 63, 84),
                      ),
                      child: TextButton(
                          child: const Text("Nuevo Reabastecimiento", //Boton de iniciar sesion
                            textAlign: TextAlign.center ,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),),
                          onPressed: () async{
                            await Navigator.pushNamed(context, '/newresupply');
                            setState(() {});
                          }  //a donde deberia mandar el boton iniciar sesion
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Historial de reabastecimientos',
                  style: TextStyle(
                    color: Color.fromARGB(255, 115, 113, 113),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                  future: getResupplies(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(), // Desactiva el desplazamiento
                        shrinkWrap: true, // Hace que la cuadrícula se ajuste a su contenido
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // Número de columnas
                          crossAxisSpacing: 10.0, // Espacio horizontal entre elementos
                          mainAxisSpacing: 10.0, // Espacio vertical entre elementos
                          childAspectRatio: 5 / 3,
                        ),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return ResupplyCardWidget(
                              date: (snapshot.data![index]['date'] as Timestamp).toDate().toString(),
                              branch: snapshot.data?[index]['branch'],
                              total: snapshot.data?[index]['total'],
                              orders: snapshot.data?[index]['arrayorders']
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

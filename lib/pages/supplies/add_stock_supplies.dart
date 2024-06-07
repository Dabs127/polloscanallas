import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polloscanallas/utils_widgets/appbar_widget.dart';
import 'package:polloscanallas/utils_widgets/form_container_widget.dart';
import 'package:polloscanallas/utils_widgets/redbutton_widget.dart';

import '../../services/firebase_service.dart';

class AddStockSuppliesPage extends StatefulWidget {
  const AddStockSuppliesPage({super.key});

  @override
  State<AddStockSuppliesPage> createState() => _AddStockSuppliesPageState();
}

class _AddStockSuppliesPageState extends State<AddStockSuppliesPage> {

  TextEditingController quantityController = TextEditingController();
  String selectedSupply = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, children: [

            const SizedBox(height: 5.0), // Espacio entre el subtítulo y los campos de entrada

            const Divider(color: Colors.redAccent, thickness: 4,),

            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(
                child: Text(
                  'Agregar Existencias',
                  style: TextStyle(fontSize: 30, fontFamily: "Rye"),
                ),
              ),
            ),

            const Divider(color: Colors.redAccent, thickness: 4),

            const SizedBox(height:100.0), // Espacio entre el título y los campos de entrada

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("supplies").snapshots(),
                builder: (context, snapshot){
                  List<DropdownMenuItem> suppliesItems = [];
                  if(!snapshot.hasData){
                    const CircularProgressIndicator();
                  } else {
                    final supplies = snapshot.data?.docs.reversed.toList();
                    suppliesItems.add(const DropdownMenuItem(
                        value: "",
                        child: Text(
                          "Insumos",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 100, 100, 100),
                              fontWeight: FontWeight.w500
                          ),
                        ) ),);
                    for(var supply in supplies!){
                      suppliesItems.add(
                          DropdownMenuItem(
                              value: supply.id,
                              child: Text(
                                supply['name'],
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 100, 100, 100),
                                    fontWeight: FontWeight.w500
                                ),
                              )
                          )
                      );
                    }
                  }
                  return DropdownButton(
                    items: suppliesItems,
                    onChanged: (productValue){
                      setState(() {
                        selectedSupply = productValue;
                      });

                      print(productValue);
                    },
                    value: selectedSupply,
                    isExpanded: false,
                  );
                }),
            const SizedBox(height: 80.0),
            FormContainerWidget(
              controller: quantityController,
              hintText: "Cantidad",
              isPasswordField: false, isNumberOnly: true,
            ),
            const SizedBox(height: 30.0),
            RedButtonWidget(text: "Confirmar", function: () async {

              if(selectedSupply != ""){
                await addStock(
                    selectedSupply,
                    'supplies',
                    int.parse(quantityController.text)
                ).then((_) => Navigator.pop(context));
              } else {
                // set up the button
                Widget okButton = TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    return Navigator.pop(context);
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: const Text("Ningun producto seleccionado"),
                  content: const Text("No ah escogido ningun producto al que agregarle mas existencia."),
                  actions: [
                    okButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            }),
            const SizedBox(height: 30.0),
            TextButton(
              onPressed: () {
                // Navegar a una ruta nombrada cuando se presiona el botón
                Navigator.pushNamed(context, '/listsupplies');
              },
              child: const Text(
                'Regresar',
                style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontSize: 16
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }


}
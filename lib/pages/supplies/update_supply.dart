import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:polloscanallas/services/supplies_services/crud_supplies.dart';
import '../../services/select_image.dart';
import '../../services/upload_image.dart';
import '../../utils_widgets/appbar_widget.dart';
import '../../utils_widgets/form_container_widget.dart';
import '../../utils_widgets/redbutton_widget.dart';

class UpdateSupplyPage extends StatefulWidget {
  const UpdateSupplyPage({super.key});

  @override
  State<UpdateSupplyPage> createState() => _UpdateSupplyPageState();
}

class _UpdateSupplyPageState extends State<UpdateSupplyPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController expenseController = TextEditingController();
  TextEditingController SKUController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  File? imagenToUpload;
  String selectedSupplier = '';



  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];
    expenseController.text = arguments['expense'].toString();
    SKUController.text = arguments['SKU'];
    descriptionController.text = arguments['description'];
    //selectedSupplier = arguments['supplier'];

    return Scaffold(
      appBar: const AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height:
                  5.0), // Espacio entre el subtítulo y los campos de entrada

              const Divider(
                color: Colors.redAccent,
                thickness: 4,
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Center(
                  child: Text(
                    'Actualizar Insumo',
                    style: TextStyle(fontSize: 30, fontFamily: "Rye"),
                  ),
                ),
              ),
              const Divider(color: Colors.redAccent, thickness: 4),

              const SizedBox(height:30.0), // Espacio entre el título y los campos de entrada

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormContainerWidget(
                          controller: nameController,
                          hintText: "Nombre",
                          isPasswordField: false, isNumberOnly: false,
                        ),
                      ),
                      Expanded(
                        child: FormContainerWidget(
                          controller: expenseController,
                          hintText: "Gasto",
                          isPasswordField: false, isNumberOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: FormContainerWidget(
                      controller: SKUController,
                      hintText: "SKU",
                      isPasswordField: false, isNumberOnly: false,
                    ),
                  ),
                  const SizedBox(height: 25.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Proovedor",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 100, 100, 100),
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 206,
                        height: 60,
                        child: InputDecorator(
                          decoration: const InputDecoration(border: OutlineInputBorder()),
                          child: DropdownButtonHideUnderline(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("suppliers").snapshots(),
                                builder: (context, snapshot){

                                  List<DropdownMenuItem> supplierItems = [];
                                  if(!snapshot.hasData){
                                    const CircularProgressIndicator();
                                  } else {
                                    final suppliers = snapshot.data?.docs.reversed.toList();


                                    supplierItems.add(
                                        DropdownMenuItem(
                                            value: selectedSupplier,
                                            child: Text(
                                              selectedSupplier == ""? "Seleccione proveedor" : selectedSupplier,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(255, 100, 100, 100),
                                                  fontWeight: FontWeight.w500
                                              ),
                                            )
                                        )
                                    );
                                    for(var supplier in suppliers!){
                                      if(selectedSupplier != supplier['name']){
                                        supplierItems.add(
                                            DropdownMenuItem(
                                                value: supplier['name'],
                                                child: Text(
                                                  supplier['name'],
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
                                  }
                                  return DropdownButton(
                                    items: supplierItems,
                                    onChanged: (supplierValue){
                                      setState(() {
                                        selectedSupplier = supplierValue;
                                      });

                                    },
                                    value: selectedSupplier,
                                    isExpanded: false,
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50.0,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: const BorderSide(width: 2, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                      ),
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      elevation: 5.0,
                      shadowColor: Colors.grey,
                    ),
                    onPressed: () async{
                      final image = await getImage();
                      setState(() {
                        imagenToUpload = File(image!.path);
                      });
                    },
                    child: const Text(
                      "Cargar imagen",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0,),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          hintText: "Ingrese una descripcion del producto",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 255, 63, 84))
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0,),
                  RedButtonWidget(text: "Confirmar",
                      function: () async {
                        String urlUploaded ='';
                        if(imagenToUpload != null){
                          urlUploaded = await uploadImage(imagenToUpload!, "products");
                        } else {
                          urlUploaded = arguments['urlImage'];
                        }

                        await updateSupplies(
                            arguments['uid'],
                            nameController.text,
                            int.parse(expenseController.text),
                            SKUController.text,
                            descriptionController.text,
                            urlUploaded.toString(),
                            selectedSupplier
                        ).then((_) => Navigator.pop(context));

                      }),
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
                ],
              ),
            ]
        ),
      ),
    );
  }
}

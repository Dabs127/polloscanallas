import 'dart:io';
import 'package:flutter/material.dart';
import 'package:polloscanallas/services/branch_services/crud_branches.dart';

import '../../services/select_image.dart';
import '../../services/upload_image.dart';
import '../../utils_widgets/appbar_widget.dart';
import '../../utils_widgets/form_container_widget.dart';
import '../../utils_widgets/redbutton_widget.dart';

class NewBranchPage extends StatefulWidget {
  const NewBranchPage({super.key});

  @override
  State<NewBranchPage> createState() => _NewBranchPageState();
}

class _NewBranchPageState extends State<NewBranchPage> {

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController phoneNumberController = TextEditingController(text: "");
  TextEditingController locationController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  File? imagenToUpload;

  @override
  Widget build(BuildContext context) {
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
                    'Añadir Sucursal',
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
                          controller: phoneNumberController,
                          hintText: "# Contacto",
                          isPasswordField: false, isNumberOnly: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0,),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: FormContainerWidget(
                      controller: locationController,
                      hintText: "Direccion",
                      isPasswordField: false, isNumberOnly: false,
                    ),
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
                        }

                        await addBranches(
                            nameController.text,
                            locationController.text,
                            phoneNumberController.text,
                            descriptionController.text,
                            urlUploaded.toString()
                        ).then((_) => Navigator.pop(context));

                      }),
                  TextButton(
                    onPressed: () {
                      // Navegar a una ruta nombrada cuando se presiona el botón
                      Navigator.pushNamed(context, '/listbranches');
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:polloscanallas/services/products_services/get_names.dart';
import 'package:polloscanallas/services/resupplies_services.dart';
import 'package:polloscanallas/utils_widgets/form_container_widget.dart';

import '../utils_widgets/redbutton_widget.dart';

class NewResupplyPage extends StatefulWidget {
  const NewResupplyPage({super.key});

  @override
  State<NewResupplyPage> createState() => _NewResupplyPageState();
}

class _NewResupplyPageState extends State<NewResupplyPage> {

  List<Map<String, dynamic>> productList = []; // Definición de la lista que se mostrara al agregar productos
  late List<Map<String, dynamic>> productNamesAndPrice;//Lista de comidas
  TextEditingController quantityController = TextEditingController();

  String selectedBranch = '';
  String selectedProduct = '';//Variable donde se almacena lo que seleccione el usuario
  // Obtener la fecha actual
  DateTime now = DateTime.now();
  int total = 0;

  @override
  void initState() {
    super.initState();
    loadProductNames(); // Carga los nombres de los productos al iniciar el estado del widget
  }

  Future<void> loadProductNames() async {
    productNamesAndPrice = await getProductNamesAndPrice(); // Espera a que la lista de nombres de productos esté disponible
    setState(() {
      print(productNamesAndPrice);
    });
  }

  @override
  Widget build(BuildContext context) {

    // Formatear la fecha como día, mes y año
    String formattedDate = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year.toString()}';


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 0.0), // Espacio superior
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo_fondo_blanco.jpg', // Ruta de la imagen
                      width: 100.0, // Ancho de la imagen
                      height: 100.0, // Alto de la imagen
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
                              color: Colors.redAccent,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height:5.0), // Espacio entre el subtítulo y los campos de entrada

                const Divider(
                  color: Colors.redAccent,
                  thickness: 4,
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Center(
                    child: Text(
                      'Nuevo Reabastecimiento',
                      style: TextStyle(fontSize: 30, fontFamily: "Rye"),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.redAccent,
                  thickness: 4,
                ),

                const SizedBox(height:5.0), // Espacio entre el título y los campos de entrada

                //Texto encima del desplegable
                const Text(
                  'Enviar a: ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 115, 113, 113),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height:10.0),

                //Lista desplegable
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 115, 113, 113),
                      width: 2.5,
                    ),

                    color: const Color.fromARGB(255, 255, 255, 255), // Color de fondo del botón
                  ),
                  child: SizedBox(
                    width: 206,
                    height: 60,
                    child: InputDecorator(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      child: DropdownButtonHideUnderline(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("branches").snapshots(),
                            builder: (context, snapshot){
                              List<DropdownMenuItem> branchesItems = [];
                              if(!snapshot.hasData){
                                const CircularProgressIndicator();
                              } else {
                                final branches = snapshot.data?.docs.reversed.toList();
                                branchesItems.add(const DropdownMenuItem(
                                    value: "",
                                    child: Text(
                                      "Seleccione sucursal",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(255, 100, 100, 100),
                                          fontWeight: FontWeight.w500
                                      ),
                                    ) ),);
                                for(var branch in branches!){
                                  branchesItems.add(
                                      DropdownMenuItem(
                                          value: branch['name'],
                                          child: Text(
                                            branch['name'],
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
                                items: branchesItems,
                                onChanged: (supplierValue){
                                  setState(() {
                                    selectedBranch = supplierValue;
                                  });

                                  print(supplierValue);
                                },
                                value: selectedBranch,
                                isExpanded: false,
                              );
                            }),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height:10.0),

                //Fecha del día ingresado
                Text(
                  'Fecha: $formattedDate',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 115, 113, 113),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height:10.0),

                const Text(
                  'Productos a enviar:',
                  style: TextStyle(
                    color: Color.fromARGB(255, 115, 113, 113),
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("products").snapshots(),
                            builder: (context, snapshot){
                              List<DropdownMenuItem> productsItems = [];
                              if(!snapshot.hasData){
                                const CircularProgressIndicator();
                              } else {
                                final products = snapshot.data?.docs.reversed.toList();
                                productsItems.add(const DropdownMenuItem(
                                    value: "",
                                    child: Text(
                                      "Productos",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 100, 100, 100),
                                          fontWeight: FontWeight.w500
                                      ),
                                    ) ),);
                                for(var product in products!){
                                  productsItems.add(
                                      DropdownMenuItem(
                                          value: product['name'],
                                          child: Text(
                                            product['name'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(255, 100, 100, 100),
                                                fontWeight: FontWeight.w500
                                            ),
                                          )
                                      )
                                  );
                                }
                              }
                              return SizedBox(
                                width: 50,
                                height: 150,
                                child: DropdownButton(
                                  underline: Container(),
                                  items: productsItems,
                                  onChanged: (productValue){
                                    setState(() {
                                      selectedProduct = productValue;
                                      print(selectedProduct);
                                    });

                                  },
                                  value: selectedProduct,
                                  isExpanded: false,
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: FormContainerWidget(
                          controller: quantityController,
                          hintText: "Cantidad",
                          isNumberOnly: true,
                          isPasswordField: false,
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 13),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.redAccent,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: IconButton(
                        onPressed: (){
                          String nameForGetThePrice = selectedProduct;
                          int price = -1;

                          for (var product in productList) {
                            if(product['name'] == nameForGetThePrice){
                              return;
                            }
                          }

                          for (var product in productNamesAndPrice) {
                            if(product['name'] == nameForGetThePrice){
                              price = product['price'];
                            }
                          }

                          if(price == -1 || quantityController.text == ''){
                            return;
                          }

                          total += (price * int.parse(quantityController.text));

                          setState(() {
                            productList.add({
                              "name": selectedProduct,
                              "price": price,
                              "quantity": quantityController.text
                            });

                            quantityController.text = '';
                          });
                          print(productList);
                        },
                        icon: const Icon(
                          Icons.add
                        ),
                        color: Colors.redAccent,
                    ),
                  ),
                ),

                const SizedBox(height:10.0),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Text(
                            'Producto',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 63, 84),
                            ),
                          ),
                          Divider(color: Colors.redAccent, thickness: 2)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Text(
                            'Precio',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 63, 84),
                            ),
                          ),
                          Divider(color: Colors.redAccent, thickness: 2)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Column(
                        children: [
                          Text(
                            'Cantidad',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 63, 84),
                            ),
                          ),
                          Divider(color: Colors.redAccent, thickness: 2)
                        ],
                      ),
                    ),
                  ],
                ),

                Column(
                  children: productList.map((product) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     Container(
                        margin: const EdgeInsets.only(left: 5, top: 10),
                         child: SizedBox(width: 100, child: Text(product['name']))
                     ),
                     Container(
                         margin: const EdgeInsets.only(left: 20, top: 10),
                         child: SizedBox(width: 50, child: Text(product['price'].toString()))
                     ),
                     Container(
                         margin: const EdgeInsets.only(left: 50, top: 10),
                         child: SizedBox(width: 50, child: Text(product['quantity'].toString()))
                     )
                   ],
                  )
                  ).toList(),
                ),

                const SizedBox(height:15.0),

                //Boton de Confirmar
                Center(
                  child: RedButtonWidget(text: "Confirmar",
                      function: () async {
                        if(selectedBranch == '' || productList.isEmpty){
                          return;
                        }

                        await addResupplies(
                            selectedBranch,
                            Timestamp.now(),
                            total,
                            productList
                        ).then((_) => Navigator.pop(context));
                      }),
                ),

                const SizedBox(height:10.0),

                //Boton de Regresar
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navegar a una ruta nombrada cuando se presiona el botón
                      Navigator.pushNamed(context, '/resupply'/* Modifica esto para la dirección*/);
                    },
                    child: const Text(
                      'Regresar',
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontSize: 22
                      ),
                    ),
                  ),
                ),
                //Importa mucho
              ]
          ),
        ),
      ),
    );
  }
}
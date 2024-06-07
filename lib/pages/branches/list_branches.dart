import 'package:flutter/material.dart';
import 'package:polloscanallas/services/branch_services/crud_branches.dart';

import '../../services/products_services/crud_products.dart';
import '../../services/user_auth/firebase_auth_services.dart';
import '../../utils_widgets/appbar_widget.dart';
import '../../utils_widgets/card_forlist_widget.dart';
import '../../utils_widgets/drawer_widget.dart';

class ListBranchesPage extends StatefulWidget {
  const ListBranchesPage({super.key});

  @override
  State<ListBranchesPage> createState() => _ListBranchesPageState();
}

class _ListBranchesPageState extends State<ListBranchesPage> {

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
      appBar: const AppbarWidget(),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [

          const SizedBox(height: 5.0), // Espacio entre el subtítulo y los campos de entrada

          const Divider(color: Colors.redAccent, thickness: 4,),

          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: Text(
                'Sucursales',
                style: TextStyle(fontSize: 30, fontFamily: "Rye"),
              ),
            ),
          ),

          const Divider(color: Colors.redAccent, thickness: 4),

          const SizedBox(height:30.0), // Espacio entre el título y los campos de entrada

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 70,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 63, 84),
                    ),
                    child: TextButton(
                        child: const Text("Nueva Sucursal", //Boton de iniciar sesion
                          textAlign: TextAlign.center ,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),),
                        onPressed: () async{
                          await Navigator.pushNamed(context, '/newbranch');
                          setState(() {});
                        }  //a donde deberia mandar el boton iniciar sesion
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30.0),

          FutureBuilder(
              future: getBranches(),
              builder: ((context, snapshot) {
                if(snapshot.hasData){
                  return Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return CardForlistWidget(
                            notifyParent: refresh,
                            properties: {
                              'urlImage': snapshot.data?[index]['url'],
                              'name': snapshot.data?[index]['name'],
                              'location': snapshot.data?[index]['location'],
                              'phonenumber': snapshot.data?[index]['phonenumber'],
                              'description': snapshot.data?[index]['description'],
                              'type': snapshot.data?[index]['type'],
                              'uid': snapshot.data?[index]['uid'],
                            },
                            updateRoute: '/updatebranch',
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
          ),
        ]),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

}

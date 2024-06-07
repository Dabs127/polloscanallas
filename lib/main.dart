import 'package:flutter/material.dart';
import 'package:polloscanallas/pages/branches/list_branches.dart';
import 'package:polloscanallas/pages/branches/new_branch.dart';
import 'package:polloscanallas/pages/branches/update_branch.dart';
import 'package:polloscanallas/pages/home.dart';
import 'package:polloscanallas/pages/login.dart';
import 'package:polloscanallas/pages/new_resupply.dart';
import 'package:polloscanallas/pages/products/add_stock_products.dart';
import 'package:polloscanallas/pages/products/list_products.dart';
import 'package:polloscanallas/pages/products/new_product.dart';
import 'package:polloscanallas/pages/products/update_product.dart';
import 'package:polloscanallas/pages/resupply.dart';
import 'package:polloscanallas/pages/sign_up.dart';
import 'package:polloscanallas/pages/suppliers/list_suppliers.dart';
import 'package:polloscanallas/pages/suppliers/new_supplier.dart';
import 'package:polloscanallas/pages/suppliers/update_supplier.dart';
import 'package:polloscanallas/pages/supplies/add_stock_supplies.dart';
import 'package:polloscanallas/pages/supplies/list_supplies.dart';
import 'package:polloscanallas/pages/supplies/new_supply.dart';

// Importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:polloscanallas/pages/supplies/update_supply.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    routes: {
      '/signup': (context) => const CreatePage(),
      '/login': (context) => const LoginPage(),
      '/home': (context) => const HomePage(),
      '/listproducts': (context) => const ListProductsPage(),
      '/newproduct': (context) => const NewProductPage(),
      '/addstockproducts': (context) => const AddStockProductsPage(),
      '/updateproduct': (context) => const UpdateProductPage(),
      '/listsupplies': (context) => const ListSuppliesPage(),
      '/newsupply': (context) => const NewSupplyPage(),
      '/updatesupply': (context) => const UpdateSupplyPage(),
      '/addstocksupplies': (context) => const AddStockSuppliesPage(),
      '/listsuppliers': (context) => const ListSuppliersPage(),
      '/newsupplier': (context) => const NewSupplierPage(),
      '/updatesupplier': (context) => const UpdateSupplierPage(),
      '/listbranches': (context) => const ListBranchesPage(),
      '/newbranch': (context) => const NewBranchPage(),
      '/updatebranch': (context) => const UpdateBranchPage(),
      '/resupply': (context) => const ResupplyPage(),
      '/newresupply': (context) => const NewResupplyPage()
    },
  ));
}

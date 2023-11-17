import 'package:flutter/material.dart';
import 'screens/clientes_screen.dart';
import 'screens/funcionarios_screen.dart';
import 'screens/carros_screen.dart';
import 'screens/login.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:primeiro_app/firebase_options.dart'; 
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: web,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lava Jato Flutter',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    ClientesScreen(),
    FuncionariosScreen(),
    CarrosScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPopupMenuSelected(String value) {
    switch (value) {
      case 'cadastro_Clientes':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClientesScreen()),
        );
        break;
      case 'cadastro_funcionario':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FuncionariosScreen()),
        ); 
        break;
      case 'cadastro_carro':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CarrosScreen()),
        ); 
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lava Jato'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _onPopupMenuSelected,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'cadastro_Clientes',
                  child: Text('Cadastro de Cliente'),
                ),
                PopupMenuItem(
                  value: 'cadastro_funcionario',
                  child: Text('Cadastro de Funcionário'),
                ),
                PopupMenuItem(
                  value: 'cadastro_carro',
                  child: Text('Cadastro de Carros'),
                ),
              ];
            },
          ),
        ],
      ),
      
    );
  }
}

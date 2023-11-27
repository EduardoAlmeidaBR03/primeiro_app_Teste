import 'package:flutter/material.dart';
import 'package:primeiro_app/crud/cadastro_ordem_servico_screen.dart';
import 'package:primeiro_app/screens/listascreens/listaordemservico_screens.dart';
import 'package:primeiro_app/screens/ordem_servico_screen.dart';
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
/// LISTA PARA O CARD QUE SERÁ ALTERADA///
class _MyHomePageState extends State<MyHomePage> {


    List<Map<String, String>> ordensDeServico = [
    {
      'cliente': 'João da Silva',
      'carro': 'Fiat Uno',
      'funcionario': 'Pedro Almeida'
    },
    {
      'cliente': 'Maria Oliveira',
      'carro': 'Volkswagen Gol',
      'funcionario': 'Ana Souza'
    },
    {
      'cliente': 'Carlos Santos',
      'carro': 'Ford Fiesta',
      'funcionario': 'José Pereira'
    },

  ];



  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    ClientesScreen(),
    FuncionariosScreen(),
    CarrosScreen(),
    OrdemServicoScreen(),
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
      case 'cadastro_ordem_servico':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrdemServicoScreen()),
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
                PopupMenuItem(
                  value: 'cadastro_ordem_servico',
                  child: Text('Cadastro de Ordens de Serviços'),
                ),
              ];
            },
          ),
        ],
      ),
     
/// CARD PARA AS ORDENS DE SERVIÇO///
    body: ListView.builder(
      itemCount: ordensDeServico.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              title: Text('Cliente: ${ordensDeServico[index]['cliente']}'),
              subtitle: Text('Carro: ${ordensDeServico[index]['carro']}'),
              // Adicione esta linha para os funcionários
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 10), // Espaçamento entre os botões
                  Text('Funcionário: ${ordensDeServico[index]['funcionario']}'),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      _excluirOrdemServico(index);
                    },
                  ),
                ],
              ),
              onTap: () {
                ListaOrdemServicoScreen();
              },
            ),
          ),
        );
      },
    ),



      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroOrdemServicoScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 29, 43, 122),
      ),
    );
  }


/// FUNÇÃO PARA EXCLUIR O CARD///
  void _excluirOrdemServico(int index) {
    setState(() {
      ordensDeServico.removeAt(index);
    });
  }
}
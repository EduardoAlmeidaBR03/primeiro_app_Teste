import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_app/crud/cadastro_ordem_servico_screen.dart';
import 'package:primeiro_app/screens/listascreens/listaordemservico_screens.dart';
import 'package:primeiro_app/screens/ordem_servico_screen.dart';
import 'screens/clientes_screen.dart';
import 'screens/funcionarios_screen.dart';
import 'screens/carros_screen.dart';
import 'screens/login.dart';
import 'screens/servicos_arquivados_screen.dart';
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
    OrdemServicoScreen(),
    ServicosArquivadosScreen()
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
      case 'visualizar_servicos_arquivados':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServicosArquivadosScreen()),
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
                PopupMenuItem(
                value: 'visualizar_servicos_arquivados', // Adiciona a opção de visualizar serviços arquivados
                child: Text('Visualizar Serviços Arquivados'),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ordens_servico').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados'));
          }
          List<DocumentSnapshot> ordens = snapshot.data!.docs;
          return ListView.builder(
            itemCount: ordens.length,
            itemBuilder: (context, index) {
              var ordem = ordens[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text('Carro: ${ordem['carro']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Placa: ${ordem['placa']}'),
                        Text('Funcionário: ${ordem['funcionario']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            _excluirOrdemServico(index);
                          },
                        ),
                        SizedBox(width: 8), // Adiciona um espaço entre os botões
                        ElevatedButton( // Adiciona o botão "Arquivar"
                          onPressed: () {
                            //_arquivarOrdemServico(ordem.id); // Chama a função para arquivar a ordem de serviço
                          },
                          child: Text('Arquivar'),
                        ),
                      ],
                    ),
                    leading: Text('Cliente: ${ordem['cliente']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListaOrdemServicoScreen()),
                      );
                    },
                  ),
                ),
              );
            },
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


  void _excluirOrdemServico(int index) {
  FirebaseFirestore.instance.collection('ordens_servico').get().then((snapshot) {
    snapshot.docs[index].reference.delete();
  });
}
}


void arquivarOrdemServico(String ordemId) {
  FirebaseFirestore.instance.collection('ordens_servico').doc(ordemId).update({
    'arquivada': true, 
  }).then((value) {
    print('Ordem de serviço arquivada com sucesso');
  }).catchError((error) {
    print('Erro ao arquivar ordem de serviço: $error');
  });
}


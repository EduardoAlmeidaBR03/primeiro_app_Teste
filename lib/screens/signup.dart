
import 'dart:ui'; // Importe dart:ui para usar ImageFilter
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:primeiro_app/main.dart'; // Substitua pelo caminho correto do arquivo principal

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isFieldFocused = false;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _nameFocusNode.addListener(() {
      setState(() {
        _isFieldFocused = _nameFocusNode.hasFocus || _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
      });
    });

    _emailFocusNode.addListener(() {
      setState(() {
        _isFieldFocused = _nameFocusNode.hasFocus || _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        _isFieldFocused = _nameFocusNode.hasFocus || _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/jato.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_isFieldFocused)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(color: Colors.black.withOpacity(0)),
            ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      focusNode: _nameFocusNode,
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome Completo',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      focusNode: _emailFocusNode,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      focusNode: _passwordFocusNode,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Cria o usuário com o email e senha fornecidos
                  await _auth.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  // Se o cadastro for bem-sucedido, redirecione para MyHomePage
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                } on FirebaseAuthException catch (e) {
                  // Se ocorrer um erro, exiba uma mensagem
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.message ?? 'Erro ao realizar o cadastro.'),
                  ));
                }
              },
              child: Text('Cadastrar'),
            ),
                    // ...
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

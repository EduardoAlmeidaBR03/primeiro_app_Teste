import 'dart:ui'; // Importe dart:ui para usar ImageFilter
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:primeiro_app/main.dart'; // Substitua pelo caminho correto
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _passwordVisible = false;
  bool _isFieldFocused = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      setState(() {
        _isFieldFocused = _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
      });
    });

    _passwordFocusNode.addListener(() {
      setState(() {
        _isFieldFocused = _emailFocusNode.hasFocus || _passwordFocusNode.hasFocus;
        
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagem de Fundo
          Container(
            height: 200, // Reduzindo a altura da imagem de fundo
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/jato.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Aplica o desfoque na imagem de fundo quando um campo de texto é focado
          if (_isFieldFocused)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(color: Colors.black.withOpacity(0)),
            ),
          Column(
            children: <Widget>[
              SizedBox(height: 50), // Adicionando espaço acima dos campos de login
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
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
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CadastroPage()),
                          );
                        },
                        child: Text(
                          'Não tem uma conta? Cadastre-se',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Texto preto
                            fontSize: 16, // Tamanho maior da fonte
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                              email: "almeida@gmail.com",
                              password: "123456",
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.message ?? 'Erro ao realizar o login.'),
                            ));
                          }
                        },
                        child: Text('Entrar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:chat/Models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>(); // Acessando dados do meu formulário
  final _formData = AuthFormData(); // Usando a classe que foi criada

  void _submit() {
    _formkey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              if (_formData.isSignup) // condicional, se for signup
                TextFormField(
                  key: const ValueKey(
                      'name'), // neste caso esta atribuindo nome ao valor, ára não mudar na alternancia
                  initialValue: _formData
                      .name, // usando ele como inicial, mesmo se o valor sumir ele permanece com o valor
                  onChanged: (name) =>
                      _formData.name = name, // guardando o valor digitado
                  decoration: const InputDecoration(labelText: 'nome'),
                  validator: (value) {
                    if (value == null || value.trim().length < 5) {
                      return "O nome deve ter pelo menos 5 caracteres";
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                validator: (value) {
                  final RegExp emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value!)) {
                    return "Email inválido";
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true, //para deixar o texto ofuscado
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (valor) {
                  if (valor == null || valor.trim().length < 8) {
                    return "a senha deve ter pelo menos 8 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'), //botao
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(_formData.isLogin
                    ? 'Criar uma nova conta?'
                    : 'Já possui uma conta?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

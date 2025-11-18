import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>(); // acessando dados do formulário
  final _formData = AuthFormData(); //usando a classe que foi criada

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, //chave do formulário
          child: Column(
            children: [
              if (_formData
                  .isSignup) //condicional, o nome só vai aparecer se for modo Signup o nome será renderizado
                TextFormField(
                  key: const ValueKey(
                      'name'), //neste caso está atribuindo o nome ao valor, para não mudar na alternancia.
                  initialValue: _formData
                      .name, //usando ele como inicial, mesmo se o valor sumir ele permanece com o valor
                  onChanged: (name) =>
                      _formData.name = name, //guardando o valor.
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (localName) {
                    final name = localName ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (localEmail) {
                  final email = localEmail ?? '';
                  if (!email.contains('@')) {
                    return 'E-mail informado não é válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true, //para deixar o texto ofuscado
                decoration: const InputDecoration(labelText: 'Senha'),
                validator: (localPassword) {
                  final password = localPassword ?? '';
                  if (password.length <= 6) {
                    return 'Senha deve ter no mínimo 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit, //associando ao método
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'), //botao
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode(); //alternar os modos
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ), //texto com comportamento de clique
              )
            ],
          ),
        ),
      ),
    );
  }
}

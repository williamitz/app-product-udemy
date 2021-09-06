import 'package:flutter/material.dart';
import 'package:product_app/providers/login_frm.provider.dart';
import 'package:product_app/services/storage.service.dart';
import 'package:product_app/ui/ui.dialogs.dart';
import 'package:provider/provider.dart';

import 'package:product_app/ui/input.decoration.dart';
import 'package:product_app/widgets/widgets.module.dart';

class LoginPage extends StatelessWidget {
  // const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BackgroundLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250.0),
              CardLogin(
                child: Column(
                  children: [
                    SizedBox(height: 20.0,),
                    Text('Ingresar', style: Theme.of(context).textTheme.headline5,),
                    SizedBox(height: 20.0,),

                    ChangeNotifierProvider(
                      create: (_) => LoginFrmProvider(),
                      child: _FormLogin(),
                      
                    ),

                    

                    SizedBox(height: 40.0,),
                  ],
                )
              ),
              SizedBox(height: 60.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container()),
                  Text('No tienes una cuenta? '),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'singin'),
                    child: Text(
                      'Crear cuenta',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w700
                      ),
                    )
                  ),
                  Expanded(child: Container()),
                  
                ],
              )

            ],
          ),
        ),
      ),

    );
  }

  
}

class _FormLogin extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final _loginFrmProvider = Provider.of<LoginFrmProvider>(context);
    final _st = StorageService();

    return Form(
      key: _loginFrmProvider.loginFrmKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            _buildEmail( _loginFrmProvider ),
            SizedBox(height: 20.0,),
            _buildPassword( _loginFrmProvider ),

            SizedBox(height: 50.0,),

            MaterialButton(
              disabledColor: Colors.grey,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                child: Text('Login', style: TextStyle(color: Colors.white)),
              ),
              shape: StadiumBorder(),
              onPressed: _loginFrmProvider.isValid ? ( ) async {

                if (! _loginFrmProvider.isValid) return;

                _showLoading(context);
                final res = await _loginFrmProvider.onLogin();
                print('response$res');
                Navigator.of(context).pop();
                if(!res['ok']) {
                  return _showAlert( context, Icons.warning, 'Error interno del servidor' );
                }

                final showError = res['showError'] ?? 0;
                final icon = showError == 0 ? Icons.check : Icons.warning;

                _showAlert( context, icon, _getError( showError ) );
                if (showError == 0) {
                  _st.token = res['token'] ?? '';
                  Navigator.of(context).pushReplacementNamed('home');
                }
                // 

              } : null
              // onPressed: _loginFrmProvider.isValid() ? _submit : null
            ),

          ],
        ),
      )
    );
  }

  void _showLoading( BuildContext context ) {
    showDialog(
      context: context,
      builder: ( context ) {
        return Loadingw();
      }
    );
  }

  void _showAlert( BuildContext context, IconData icon, String msg ) {
    showDialog(
      context: context,
      builder: ( context ) {
        return Alertw(iconAlert: icon, message: msg);
      }
    );
  }

  String _getError( int showError ) {
    List<String> error = showError == 0 ? ['Bienvenido'] : ['Alerta'];

    if (showError == 1) {
      error.add('(Usuario) o contraseña incorrectos');
    }

    if (showError == 2) {
      error.add('Usuario o (contraseña) incorrectos');
    }

    return error.join(', ');
  }

  TextFormField _buildEmail( LoginFrmProvider bloc ) =>  TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: UiDecoration.authDecoration(
      labelText: 'Email', 
      prefixIcon: Icons.alternate_email_outlined
    ),
    onChanged: (value) => bloc.user = value,
    validator: (value) {
      
      String error = '';

      if (value == null || value == '') error = 'Requerido';

      final regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

      if (!regex.hasMatch(value.toString()) && value != null ) error += 'Email inválido';

      return error == '' ? null : error;
    },
  );

  TextFormField _buildPassword( LoginFrmProvider bloc ) =>  TextFormField(
    obscureText: true,
    decoration: UiDecoration.authDecoration(
      labelText: 'Password', 
      prefixIcon: Icons.lock_outline
    ),
    onChanged: (value) => bloc.password = value,
    validator: (value) {
      String error = '';
      if (value == null || value == '') error = 'Requerido';
      if ( value != null && value.trim().length < 6 ) error = 'Mínimo 6 caracteres';

      return error == '' ? null : error;
    },
  );

  
}
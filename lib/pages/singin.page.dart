import 'package:flutter/material.dart';
import 'package:product_app/services/storage.service.dart';
import 'package:provider/provider.dart';

import 'package:product_app/providers/singin.provider.dart';
import 'package:product_app/ui/input.decoration.dart';
import 'package:product_app/ui/ui.dialogs.dart';
import 'package:product_app/widgets/background.login.dart';
import 'package:product_app/widgets/card.login.dart';

class SinginPage extends StatelessWidget {
  // const SinginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundLogin(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 180.0),
              CardLogin(
                child: Column(
                  children: [
                    SizedBox(height: 20.0,),
                    Text('Crear cuenta', style: Theme.of(context).textTheme.headline5,),
                    SizedBox(height: 20.0,),

                    ChangeNotifierProvider(
                      create: (_) => SinginProvider(),
                      child: _SinginForm(),
                    ),
                    SizedBox(height: 20.0,),

                  ],
                ),
              ),
              SizedBox(height: 40.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: Container()),
                  Text('Ya tienes una cuenta? '),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'login'),
                    child: Text(
                      'Login',
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
      )
    );
  }
}

class _SinginForm extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final _singinProvider = Provider.of<SinginProvider>(context);
    final _enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.deepPurple,
      )
    );

    final _focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.deepPurple,
        width: 2.0
      )
    );
    
    final _labelStyle = TextStyle( color: Colors.deepPurple );

    final _st = StorageService();

    return Form(
      key: _singinProvider.singinFrmKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _buildinputName(_singinProvider),
          SizedBox(height: 15.0,),
          _buildInputPhone(_labelStyle, _enabledBorder, _focusedBorder, _singinProvider),
          SizedBox(height: 15.0,),
          _buildInputEmail(_singinProvider),
          SizedBox(height: 15.0,),

          _buildInputPass(_labelStyle, _enabledBorder, _focusedBorder, _singinProvider),

          SizedBox(height: 15.0,),

          _buildInputConfirm(_singinProvider),

          SizedBox(height: 50.0,),

          MaterialButton(
            disabledColor: Colors.grey,
            color: Colors.deepPurple,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Crear cuenta', style: TextStyle(color: Colors.white)),
            ),
            shape: StadiumBorder(),
            onPressed: ( ) async{

              if (! _singinProvider.isValid()) return;

              showDialog(
                context: context,
                builder: ( context ) {
                  return Loadingw();
                }
              );

              final res = await _singinProvider.onCreateAccount();
              Navigator.of(context).pop();

              print('showError ${ res["showError"] ?? -1 }');
              print('showError ${ res["ok"] ?? 'none' }');

              if (res["ok"] == false ) {
                _showAlert( context, Icons.close, 'Error interno del servidor');
              } else {
                final showError = res["showError"] ?? 0;
                final icon = showError == 0 ? Icons.check : Icons.close;
                _showAlert(context, icon,  _getError( showError ) );

                if (showError == 0) {
                  _st.token = res['token'] ?? '';
                  // Navigator.pushReplacementNamed(context, 'home');
                  Navigator.of(context).pushReplacementNamed('home');
                }

              }

            }
            // onPressed: _loginFrmProvider.isValid() ? _submit : null
          ),

        ],
      )
    );
  }

  String _getError( int showError ) {
    List<String> error = showError == 0 ? ['Bienvenido'] : ['Alerta', 'Ya existe un usuario'];

    if (showError == 1) {
      error.add('con este email');
    }

    if (showError == 2) {
      error.add('con este teléfono');
    }

    if (showError == 3) {
      error.add('con este email');
      error.add('con este teléfono');
    }
    return error.join(', ');
  }


  Future _showAlert( BuildContext context, IconData iconAlert, String msg ){
    return showDialog(
      context: context,
      builder: ( context ) {
        return Alertw(iconAlert: iconAlert, message: msg);
      }
    );
  }

  Widget _buildInputConfirm(SinginProvider _singinProvider) {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            obscureText: true,
            decoration: UiDecoration.authDecoration(labelText: 'Confirmar contraseña'),
            onChanged: (value) => _singinProvider.singinModel.confirmPassword = value,
            validator:( value ) {
              String error = '';

              if (value == null || value.length == 0) error = 'Requerido';
              if (_singinProvider.singinModel.confirmPassword != _singinProvider.singinModel.userPassword) error = 'no coinciden';

              return error == '' ? null : error;
            }

          ),
        );
  }

  Widget _buildInputPass(TextStyle _labelStyle, UnderlineInputBorder _enabledBorder, UnderlineInputBorder _focusedBorder, SinginProvider _singinProvider) {
    return Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: TextFormField(
            obscureText: !_singinProvider.showPsw,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: _labelStyle,
              enabledBorder: _enabledBorder,
              focusedBorder: _focusedBorder,
              suffixIcon: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: IconButton(
                  icon: Icon(
                    _singinProvider.showPsw ? 
                    Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined,

                    color: _singinProvider.showPsw ? 
                    Colors.deepPurple
                    : Colors.grey,
                  ),
                  onPressed: () => _singinProvider.showPsw = !_singinProvider.showPsw, 
                ),
              )
            ),
            onChanged: (value) => _singinProvider.singinModel.userPassword = value,
            validator:( value ) {
              String error = '';

              if (value == null || value.length == 0) error = 'Requerido';
              if (value != null && value.length < 6) error = 'Mínimo 6 carácteres';

              return error == '' ? null : error;
            }

          ),
        );
  }

  Widget _buildInputPhone(TextStyle _labelStyle, UnderlineInputBorder _enabledBorder, UnderlineInputBorder _focusedBorder, SinginProvider _singinProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(

        decoration: InputDecoration(
          labelText: 'Teléfono',
          labelStyle: _labelStyle,
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          prefixIcon: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Text('+51'),
          ),
        ),
        onChanged: (value) => _singinProvider.singinModel.phone = value,

      ),

    );
  }

  Widget _buildinputName(SinginProvider _singinProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(

        decoration: UiDecoration.authDecoration(labelText: 'Nombres y apellidos'),
        onChanged: (value) => _singinProvider.singinModel.fullname = value,
        validator:( value ) {
          String error = '';

          if (value == null || value.length == 0) error = 'Requerido';

          final regex = new RegExp(r'^[a-zA-Z\ áéíóúüñÁÉÍÓÚÜÑ]{0,100}$');

          if (!regex.hasMatch(value.toString()) && value != null ) error += 'Solo letras';

          return error == '' ? null : error;
        }

      ),
    );
  }

  Widget _buildInputEmail(SinginProvider _singinProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: UiDecoration.authDecoration(labelText: 'Email'),
        onChanged: (value) => _singinProvider.singinModel.email = value,
        validator:( value ) {
          String error = '';

          if (value == null || value.length == 0) error = 'Requerido';

          final regex = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

          if (!regex.hasMatch(value.toString()) && value != null ) error += 'Email inválido';

          return error == '' ? null : error;
        }

      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:form_validate_bloc/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondo(context),
          _createForm(context),
        ],
      ),
    );
  }

  Widget _fondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final colorFondo = Container(
      height: size.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(195, 12, 12, 1.0),
            Color.fromRGBO(221, 48, 51, 1.0),
          ],
        ),
      ),
    );

    final ciruclo = Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.05),
          borderRadius: BorderRadius.circular(100.0),
        ));

    return Stack(
      children: [
        colorFondo,
        Positioned(top: 90.0, left: 30.0, child: ciruclo),
        Positioned(top: -40.0, right: 30.0, child: ciruclo),
        Positioned(bottom: -50.0, right: -10.0, child: ciruclo),
        Positioned(bottom: 120.0, right: 20.0, child: ciruclo),
        Positioned(bottom: -50.0, left: -20.0, child: ciruclo),
        _header(),
      ],
    );
  }

  Widget _header() {
    return Container(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 20,
            width: double.infinity,
          )),
          Text(
            'Login',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 90,
          ),
        ],
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 180.0,
          )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Column(
              children: [
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 60.0),
                _crearCorre(bloc),
                SizedBox(height: 30.0),
                _crearClave(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
              ],
            ),
          ),
          Text('Olvido su contraseña?'),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearCorre(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.alternate_email,
                    color: Color.fromRGBO(195, 12, 12, 1.0)),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeEmail,
            ),
          );
        });
  }

  Widget _crearClave(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_open,
                  color: Color.fromRGBO(195, 12, 12, 1.0)),
              labelText: 'Clave',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.validarFormStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          onPressed: snapshot.hasData ? () => _login(context, bloc) : null,
          color: Color.fromRGBO(195, 12, 12, 1.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text(
              'Ingresar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
        );
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) {
    print('==================');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password} ');
    print('==================');

    Navigator.pushReplacementNamed(context, 'home');
  }
}

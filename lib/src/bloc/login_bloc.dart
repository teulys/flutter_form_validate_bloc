import 'dart:async';

import 'package:form_validate_bloc/src/bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validator {
  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Insertando valores a mi Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<bool> get validarFormStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  //Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  //Devolver los ultimos valores de los Steam
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}

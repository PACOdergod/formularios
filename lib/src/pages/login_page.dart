import 'package:flutter/material.dart';
import 'package:formularios/src/blocs/provider.dart';

class LoginPage extends StatelessWidget {
  //static final routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[_fondo(context), _formulario(context)],
    ));
  }

  Widget _fondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final _morado = Container(
        height: size.height * .50,
        width: size.width,
        color: Color.fromRGBO(90, 70, 178, 1.0));

    final _circulo = Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
    );

    return Stack(
      children: <Widget>[
        _morado,
        Positioned(
          child: _circulo,
          top: 20,
          left: 30,
        ),
        Positioned(
          child: _circulo,
          top: 100,
          left: 300,
        ),
        Positioned(
          child: _circulo,
          top: 250,
          left: -30,
        ),
        Positioned(
          child: _circulo,
          top: 200,
          left: 150,
        ),
      ],
    );
  }

  Widget _formulario(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of(context);

    final _nombreIcono = Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person_pin_circle,
            color: Colors.white,
            size: 100,
          ),
          SizedBox(
            width: size.width,
          ),
          Text(
            'Paco',
            style: TextStyle(color: Colors.white, fontSize: 30),
          )
        ],
      ),
    );

    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SafeArea(child: _nombreIcono),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(20),
          //margin: EdgeInsets.only(top: 20),
          width: size.width * 0.80,
          //height: 80,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 3.0)),
              ]),
          child: Column(
            children: <Widget>[
              Text(
                'Ingreso',
                style: TextStyle(fontSize: 20),
              ),
              _crearEmail(bloc),
              _crearContrasena(bloc),
              SizedBox(
                height: 15,
              ),
              _crearBoton(bloc),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('Olvido su contraseña'),
        SizedBox(
          height: 40.0,
        ),
      ],
    ));
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electronico',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearContrasena(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
                onChanged: bloc.changePassword,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline),
                    labelText: 'Contraseña',
                    //counterText: snapshot.data,
                    errorText: snapshot.error)));
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    //formValidStream

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          onPressed: snapshot.hasData ? () {} : null,
          child: Container(
            child: Text('Ingresar'),
            padding: EdgeInsets.symmetric(horizontal: 50.0),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
        );
      },
    );
  }
}

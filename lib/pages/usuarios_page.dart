import 'package:agentebcp/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:agentebcp/models/usuario.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        uid: '1',
        online: true,
        password: '646464646',
        email: 'sebitasTest@test.com',
        nombre: 'Sebastian',
        terminal: 'H900000',
        ruc: 1010101010),
  ];
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    final usuario = authServices.usuario;

    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 25),
              child: const Icon(Icons.check_circle),
              //     const Icon(
              //   Icons.check_circle,
              //   color: Color.fromARGB(255, 199, 60, 32),
              // ),s
            )
          ],
          title: Text(usuario.nombre),
          elevation: 1,
          // backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                //TODO desconectarme del socket
                Navigator.pushReplacementNamed(context, 'login');
                AuthServices.deleteToken();
              },
              icon: const Icon(Icons.exit_to_app)),
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: const WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Color(0xFFFF6D00),
            ),
            waterDropColor: Color(0xFFFF6D00),
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(
        usuario.nombre,
      ),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFFF6D00),
        child: Text(usuario.nombre.substring(0, 2),
            style: TextStyle(color: Colors.white)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  void _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}

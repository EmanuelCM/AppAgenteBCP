import 'package:flutter/material.dart';
import 'package:agentebcp/models/usuario.dart';
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
        email: 'sebitasTest@test.com',
        nombre: 'Sebastian'),
    Usuario(uid: '2', online: true, email: 'GabyTest@test.com', nombre: 'Gaby'),
    Usuario(uid: '3', online: false, email: 'EmaTes@test.com', nombre: 'Ema'),
  ];
  @override
  Widget build(BuildContext context) {
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
          title: const Text('Mi Nombre'),
          elevation: 1,
          // backgroundColor: Colors.white,
          leading:
              IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app)),
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

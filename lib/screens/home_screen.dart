import 'package:examen_final_guevara/models/tren_model.dart';
import 'package:examen_final_guevara/providers/tren_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<TrenProvider>(context);
    List<TrenModel> usuaris = TrenProvider().trenList.cast<TrenModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: ListView.builder(
              itemCount: usuaris.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: GestureDetector(
                    child: UserCard(usuari: usuaris[index]),
                    onTap: () {
                      userService.tempUser = usuaris[index].copy();
                      Navigator.of(context).pushNamed('detail');
                    },
                  ),
                  onDismissed: (direction) {
                    if (usuaris.length < 2) {
                      userService.loadUsers();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('No es pot esborrar tots els elements!')));
                    } else {
                      userService.deleteUser(usuaris[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${userService.users[index].nom} esborrat')));
                    }
                  },
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Cream un usuari temporal nou, per diferenciar-lo d'un ja creat,
          // per que aquest no tindrà id encara, i d'aquesta forma sabrem
          // discernir al detailscreen que estam creant un usuari nou i no
          // modificant un existent
          userService.tempUser = User(edat: 0, nom: '', verificat: false);
          Navigator.of(context).pushNamed('detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
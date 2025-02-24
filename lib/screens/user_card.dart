import 'package:examen_final_guevara/models/tren_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final TrenModel usuari;
  const UserCard({super.key, required this.usuari});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(usuari.nom)),
      title: Text(usuari.nom),
      subtitle: Text(
        "${usuari.edat}",
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ),
      trailing: SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
              value: usuari.verificat, onChanged: ((value) => print(value)))),
    );
  }
}

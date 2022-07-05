import 'package:diyotis_stok/models/resistors.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required Resistors resistors,
    required VoidCallback onTapEdit,
    required VoidCallback onTapDelete,
  })  : _resistors = resistors,
        _onTapEdit = onTapEdit,
        _onTapDelete = onTapDelete,
        super(key: key);
  final Resistors _resistors;
  final VoidCallback _onTapEdit;
  final VoidCallback _onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text(
          _resistors.value.toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        title: Text(_resistors.name),
        subtitle: Text(_resistors.price.toString()),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: _onTapEdit,
              child: const Icon(Icons.edit),
            ),
            GestureDetector(
              onTap: _onTapDelete,
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

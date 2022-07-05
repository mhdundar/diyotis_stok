import 'package:diyotis_stok/add_component_page.dart';
import 'package:diyotis_stok/models/resistors.dart';
import 'package:diyotis_stok/user_card.dart';
import 'package:flutter/material.dart';

import 'database/database.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({Key? key}) : super(key: key);

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DiyotisDB.getDocuments(),
      // ignore: avoid_types_on_closure_parameters
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  'Something went wrong, try again.',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('MongoDB Flutter'),
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserCard(
                      resistors: Resistors.fromMap(snapshot.data[index]),
                      onTapDelete: () async {
                        _deleteComponent(
                          Resistors.fromMap(snapshot.data[index]),
                        );
                      },
                      onTapEdit: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddComponent(),
                            settings: RouteSettings(
                              arguments:
                                  Resistors.fromMap(snapshot.data[index]),
                            ),
                          ),
                        ).then((value) => setState(() {}));
                      },
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const AddComponent();
                      },
                    ),
                  ).then((value) => setState(() {}));
                },
                child: const Icon(Icons.add),
              ),
            );
          }
        }
      },
    );
  }

  Future<void> _deleteComponent(Resistors? resistors) async {
    await DiyotisDB.delete(resistors!);
    setState(() {});
  }
}

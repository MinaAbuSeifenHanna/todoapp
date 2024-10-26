import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to/ui/app_cubit/app_cubit.dart';

class HomeScreen extends StatelessWidget {
  List<String> notes = [];
  List<String> favorites = [];
  bool isFavorites = false;
  int count = 0;

// step 1
  TextEditingController noteControl = TextEditingController();

  // step 2
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit =  AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text(
              'ToDo App',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,

          ),
          body: count == 0
              ? ListView.separated(
                  itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              isFavorites = !isFavorites;
                              isFavorites
                                  ? favorites.add(notes[index])
                                  : favorites.removeAt(index);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: isFavorites ? Colors.red : Colors.grey,
                            ),
                          ),
                          title: Text(
                            cubit.data[index]['note'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            cubit.data[index]['dateTime'],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: cubit.data.length
          )
              : ListView.separated(
                  itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              isFavorites = !isFavorites;
                              isFavorites
                                  ? favorites.add(notes[index])
                                  : favorites.removeAt(index);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: isFavorites ? Colors.red : Colors.grey,
                            ),
                          ),
                          title: Text(
                            favorites[index],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            DateTime.now().toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: favorites.length),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('To Do App'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: noteControl,
                            decoration: InputDecoration(
                              label: const Text('Notes'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              enabled: true,
                              prefixIcon: Icon(
                                Icons.note_add,
                              ),
                              //  suffixIcon: Icon(Icons.remove_red_eye_rounded),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'you must write a note';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('حفظ'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                           cubit.insertInDateBase(
                                note: noteControl.text,
                                dateTime: DateTime.now().toString());


                            noteControl.clear();
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      TextButton(
                        child: Text('إلغاء'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add_box_rounded),
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (element) {
                count = element;
              },
              currentIndex: count,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.note,
                  ),
                  label: 'Notes',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorite')
              ]),
        );
      },
    );
  }
}

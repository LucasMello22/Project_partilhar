import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

  void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     final keyApplicationId = 'DVJw0bEl5n13G8rbj2buEaxjkJv8Cuz8gkKlUsSl';
     final keyClientKey = 'OwZV5B5oPmly8aw1UQK535tpElARNvSkcFO2C';
     final keyParseServerUrl = 'https://parseapi.backapp.com';

     await Parse().initialize(keyApplicationId, keyParseServerUrl,
                 clientKey: keyClientKey, debug: true);

     runApp(MaterialApp(
               home: Home(),
             ));
      }

  class Home extends StatefulWidget {
      @override
      _HomeState createState() => _HomeState();
   }

  class _HomeState extends State<Home> {
      final todoController = TextEditingController();

      void addToDo() async {
        if (todoController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Empty title"),
            duration: Duration(seconds: 2),
          ));
          return;
        }
        await saveTodo(todoController.text);
        setState(() {
          todoController.clear();
        });
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
           title: Text("Parse Todo List"),
            backgroundColor: Colors.blueAccent,
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          autocorrect: true,
                          textCapitalization: TextCapitalization.sentences,
                          controller: todoController,
                          decoration: InputDecoration(
                              labelText: "New todo",
                              labelStyle: TextStyle(color: Colors.blueAccent)),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                          ),
                          onPressed: addToDo,
                          child: Text("ADD")),
                    ],
                  )),
              Expanded(
                  child: FutureBuilder<List<ParseObject>>(
                      future: getTodo(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: Container(
                                  width: 0,
                                  height: 0,
                                  child: CircularProgressIndicator()),
                            );
                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Error..."),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text("No Data..."),
                              );
                            } else {
                             return ListView.builder(
                                 padding: EdgeInsets.only(top: .0),
                                 itemCount: snapshot.data!.length,
                                 itemBuilder: (context, index) {
                                  //*************************************
                                   //Get Parse Object Values
                                   final varTodo = snapshot.data![index];
                                   final varTitle = '';
                                   final varDone = false;
                                   //*************************************

                                   return ListTile(
                                     title: Text(varTitle),
                                     leading: CircleAvatar(
                                       child: Icon(
                                           varDone ? Icons.check : Icons.error),
                                       backgroundColor:
                                           varDone ? Colors.green : Colors.blue,
                                       foregroundColor: Colors.white,
                                     ),
                                     trailing: Row(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Checkbox(
                                             value: varDone,
                                             onChanged: (value) async {
                                               await updateTodo(
                                                   varTodo.objectId!, value!);
                                               setState(() {
                                                 //Refresh UI
                                               });
                                             }),
                                         IconButton(
                                           icon: Icon(
                                             Icons.delete,
                                             color: Colors.blue,
                                           ),
                                           onPressed: () async {
                                             await deleteTodo(varTodo.objectId!);
                                             setState(() {
                                               final snackBar = SnackBar(
                                                 content: Text("Todo deleted!"),
                                                 duration: Duration(seconds: 2),
                                               );
                                               ScaffoldMessenger.of(context)
                                                 ..removeCurrentSnackBar()
                                                 ..showSnackBar(snackBar);
                                             });
                                           },
                                         )
                                       ],
                                     ),
                                   );
                                 });
                           }
                       }
                     }))
           ],
         ),
       );
     }

     Future<void> saveTodo(String title) async {
       await Future.delayed(Duration(seconds: 1), () {});
     }
  
     Future<List<ParseObject>> getTodo() async {
       await Future.delayed(Duration(seconds: 2), () {});
       return [];
     }
  
     Future<void> updateTodo(String id, bool done) async {
       await Future.delayed(Duration(seconds: 1), () {});
     }
  
     Future<void> deleteTodo(String id) async {
       await Future.delayed(Duration(seconds: 1), () {});
     }
   }
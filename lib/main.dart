import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
      home: MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<int> cardIds = [];
  int newId = 0;

  void addCard(){
    setState(() {
      cardIds.add(newId++);
    });
  }

  void deleteCard(int id){
    setState(() {
      cardIds.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
              "Notes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            AddButton(onPressed: addCard),
            Expanded(child:
              ListView(
                children: cardIds
                .map((id) => CardExample(
                  key: ValueKey(id),
                  onDelete: () => deleteCard(id),
                ))
                .toList(),
              )
            ),
          ],
        )
    );
  }
}

class CardExample extends StatefulWidget {
  final VoidCallback onDelete;

  const CardExample({super.key, required this.onDelete});

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  final titleCont = TextEditingController();
  final contentCont = TextEditingController();

  @override

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleCont.dispose();
    contentCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.amberAccent[100],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(controller: titleCont, decoration: InputDecoration(hintText: 'New Note')),
            TextField(
                controller: contentCont,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(hintText: 'Description'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DeleteButton(onPressed: widget.onDelete),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add),
          label: const Text('Add Note'),
          style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blueAccent)),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: const Text(
          'DELETE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          )
      ),
    );
  }
}
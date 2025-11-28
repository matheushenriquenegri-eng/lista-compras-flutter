import 'package:flutter/material.dart';
import 'package:flutter_app/item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Item> _itens = [];
  final nomeController = TextEditingController();

  void _adicionarItem() {
    String nome = nomeController.text.trim();
    Item novo = Item(nome: nomeController.text.trim());

    setState(() {
      _itens.add(novo);
    });
    Navigator.pop(context);
  }

  void _abrirDialogo() {
  nomeController.clear();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Adicionar item"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "nome"),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('cancelar'),
            ),
            ElevatedButton(
              onPressed: _adicionarItem,
              child: const Text('Adicionar'),
              ),
        ],
      );
    }
  );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: Image.asset("assets/imagens/logo-app.png"),
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _itens.length, 
        itemBuilder: (context, index) {
          Item item = _itens[index];

          return GestureDetector(
            onDoubleTap: () {
              setState(() {
                item.selecionado = !item.selecionado;
              });
            },
           child: ListTile(
            title: Text(
              item.nome, 
              style: TextStyle(
                decoration: item.selecionado 
                ? TextDecoration.lineThrough
                :TextDecoration.none,
                color: item.selecionado ? Colors.grey : Colors.black
              ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                 onPressed: () {
                  setState(() {
                    _itens.removeAt(index);
                  });
                 }
                 ),
              ),
          );
        }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirDialogo,
        tooltip: 'Novo item',
        child: const Icon(Icons.add),
      ), 
    );
  }
}

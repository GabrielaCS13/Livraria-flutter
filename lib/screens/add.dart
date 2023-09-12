import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dblivro.dart';

class AddBooks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddBooks();
  }
}

class _AddBooks extends State<AddBooks> {
  TextEditingController nome = TextEditingController();

  TextEditingController descricao = TextEditingController();

  TextEditingController autor = TextEditingController();

  TextEditingController preco = TextEditingController();

  TextEditingController roll_no = TextEditingController();

  //test editing controllers for form

  Dblivro mydb = Dblivro(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inserir livro"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nome,
                decoration: const InputDecoration(
                  hintText: "Nome livro",
                ),
              ),
              TextField(
                controller: descricao,
                decoration: const InputDecoration(
                  hintText: "Descrição do livro",
                ),
              ),
              TextField(
                controller: autor,
                decoration: const InputDecoration(
                  hintText: "Nome do autor",
                ),
              ),
              TextField(
                controller: preco,
                decoration: const InputDecoration(
                  hintText: "Preço(R\$)",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: const InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO livro(nome, descicao, autor, preco, roll_no) VALUES (?, ?, ?, ?, ?);",
                        [
                          nome.text,
                          descricao.text,
                          autor.text,
                          preco.text,
                          roll_no.text
                        ]); //add student from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Livro Adicionado")));

                    nome.text = "";

                    descricao.text = "";

                    autor.text = "";

                    preco.text = " ";

                    roll_no.text = " ";
                  },
                  child: Text("Salvar Livro")),
            ],
          ),
        ));
  }
}

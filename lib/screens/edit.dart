import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dblivro.dart';

class Edit extends StatefulWidget {
  int rollno;

  Edit({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _Edit();
  }
}

class _Edit extends State<Edit> {
  
  TextEditingController nome = TextEditingController();

  TextEditingController descricao = TextEditingController();

  TextEditingController autor = TextEditingController();

  TextEditingController preco = TextEditingController();

  TextEditingController roll_no = TextEditingController();
  

  dblivro mydb = new dblivro();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getCarro(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        nome.text = data["nome"];

        descricao.text = data["descricao"];
        
        autor.text = data["autor"];

        preco.text = data["preco"];

        roll_no.text = data["roll_no"].toString();

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Livro"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nome,
                decoration: InputDecoration(
                  hintText: "Nome",
                ),
              ),
              TextField(
                controller: descricao,
                decoration: InputDecoration(
                  hintText: "Descrição",
                ),
              ),
              TextField(
                controller: autor,
                decoration: InputDecoration(
                  hintText: "Autor",
                ),
              ),
              TextField(
                controller: preco,
                decoration: InputDecoration(
                  hintText: "Preço",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: InputDecoration(
                  hintText: "roll_no",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE livro SET nome = ?, descricao = ?, autor = ?, preco=? WHERE roll_no = ?",
                        [
                          nome.text,
                          descricao.text,
                          autor.text,
                          preco.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Livro Alterado!")));
                  },
                  child: Text("Alterar Livro")),
            ],
          ),
        ));
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PaginaInicial(),
    debugShowCheckedModeBanner: false,
  ));
}

/////////////////tela inicial////////////////////////

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {

  String nome = "Bianca Golfe";
  String descricao = "Estudante de IFC - Campus Concórdia, estou aprendendo Flutter em DSDM.";

  List<String> escolaridades = ["Ensino médio integrado com técnico em informática - IFC Concórdia"];
  List<String> projetos = ["Aplicativo de currículo feito em Flutter"];
  List<String> recomendacoes = ["Muitas"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Meu currículo"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 199, 61, 223),

        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {

              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaginaAdicionar(
                    nome,
                    descricao,
                    escolaridades,
                    projetos,
                    recomendacoes,
                  ),
                ),
              );

              if (resultado != null) {
                setState(() {
                  nome = resultado["nome"];
                  descricao = resultado["descricao"];
                  escolaridades = resultado["escolaridade"];
                  projetos = resultado["projetos"];
                  recomendacoes = resultado["recomendacoes"];
                });
              }
            },
          )
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("images/picapau.jpg"),
            ),

            SizedBox(height: 15),

            Text(
              nome,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              descricao,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 30),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaginaLista("Escolaridade", escolaridades),
                  ),
                );
              },
              child: caixa("Escolaridade"),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaginaLista("Projetos", projetos),
                  ),
                );
              },
              child: caixa("Projetos"),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaginaLista("Recomendações", recomendacoes),
                  ),
                );
              },
              child: caixa("Recomendações"),
            ),
          ],
        ),
      ),
    );
  }

  Widget caixa(String texto) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(18),
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.folder_open,
              size: 28,
              color: const Color.fromARGB(255, 199, 61, 223),
            ),

            SizedBox(width: 12),

            Text(
              texto,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 199, 61, 223),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////mostra informações/////////////////////////

class PaginaLista extends StatelessWidget {

  final String titulo;
  final List<String> lista;

  PaginaLista(this.titulo, this.lista);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: const Color.fromARGB(255, 199, 61, 223),
      ),

      body: Column(
        children: [
          Expanded(
            child: lista.isEmpty
                ? Center(child: Text("Nenhuma informação adicionada"))
                : ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {

                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading: Icon(
                            Icons.check_circle,
                            color: const Color.fromARGB(255, 199, 61, 223),
                          ),
                          title: Text(lista[index]),
                        ),
                      );
                    },
                  ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text("Voltar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 199, 61, 223),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}


////////////////////mudar informações/////////////////////////////
class PaginaAdicionar extends StatefulWidget {

  final String nomeAtual;
  final String descricaoAtual;
  final List<String> escolaridades;
  final List<String> projetos;
  final List<String> recomendacoes;

  PaginaAdicionar(
    this.nomeAtual,
    this.descricaoAtual,
    this.escolaridades,
    this.projetos,
    this.recomendacoes,
  );

  @override
  _PaginaAdicionarState createState() => _PaginaAdicionarState();
}

class _PaginaAdicionarState extends State<PaginaAdicionar> {

  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController escolaridadeController = TextEditingController();
  TextEditingController projetosController = TextEditingController();
  TextEditingController recomendacoesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nomeController.text = widget.nomeAtual;
    descricaoController.text = widget.descricaoAtual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Editar informações"),
        backgroundColor: const Color.fromARGB(255, 199, 61, 223),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            SizedBox(height: 20),

            TextField(
              controller: escolaridadeController,
              decoration: InputDecoration(
                labelText: "Adicionar Escolaridade",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: projetosController,
              decoration: InputDecoration(
                labelText: "Adicionar Projeto",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: recomendacoesController,
              decoration: InputDecoration(
                labelText: "Adicionar Recomendação",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {

                List<String> esc = List.from(widget.escolaridades);
                List<String> proj = List.from(widget.projetos);
                List<String> rec = List.from(widget.recomendacoes);

                if (escolaridadeController.text.isNotEmpty) {
                  esc.add(escolaridadeController.text);
                }

                if (projetosController.text.isNotEmpty) {
                  proj.add(projetosController.text);
                }

                if (recomendacoesController.text.isNotEmpty) {
                  rec.add(recomendacoesController.text);
                }

                Navigator.pop(context, {
                  "nome": nomeController.text,
                  "descricao": descricaoController.text,
                  "escolaridade": esc,
                  "projetos": proj,
                  "recomendacoes": rec,
                });
              },
              child: Text("Salvar"),
            )

          ],
        ),
      ),
    );
  }
}
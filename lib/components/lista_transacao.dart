import 'package:flutter/material.dart';
import '../models/transacao.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ListTransacao extends StatelessWidget {
  ListTransacao(this.transacoes, this.remover, {super.key});

  List<Transacao> transacoes;
  void Function(String) remover;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transacoes.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 10),
                const Text(
                  "PARABÉNS!!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const Text(
                  "Você não possui nehuma conta a pagar!",
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 150,
                  child: Image.asset(
                    'assests/images/nenhuma-imagem2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transacoes.length,
              itemBuilder: (contexto, index) {
                final dados = transacoes[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FittedBox(
                          child: Text(
                            'R\$${dados.valor}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      dados.titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(dados.data),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => remover(dados.id),
                    ),
                  ),
                );
              }),
    );
  }
}

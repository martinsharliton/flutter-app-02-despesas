import 'dart:math';

import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/formulario_transacao.dart';

import 'package:flutter/material.dart';
import 'components/lista_transacao.dart';
import 'models/transacao.dart';

void main(List<String> args) {
  runApp(const DespesasApp());
}

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PaginaInicial(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        fontFamily: 'OpenSans',
      ),
    );
  }
}

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final List<Transacao> _transacao = [];

  List<Transacao> get _transacoesRecentes {
    return _transacao.where((transacao) {
      return transacao.data.isAfter(DateTime.now().subtract(const Duration(
        days: 7,
      )));
    }).toList();
  }

  _adicionarTransacao(String titulo, double valor, DateTime data) {
    final newTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      data: data,
    );

    setState(() {
      _transacao.add(newTransacao);
    });

    Navigator.of(context).pop();
  }

  _deletarDespesas(String id) {
    setState(() {
      _transacao.removeWhere((elemento) => elemento.id == id);
    });
  }

  _abrirFormulario(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return FormularioTransacao(_adicionarTransacao);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "DESPESAS PESSOAIS",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        //(SingleChildScrollView) - Habilita o scrrol e corrige o overflowd no teclado
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_transacoesRecentes),
            ListTransacao(_transacao, _deletarDespesas),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirFormulario(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormularioTransacao extends StatefulWidget {
  final void Function(String, double, DateTime) enviarDados;

  const FormularioTransacao(this.enviarDados);

  @override
  _FormularioTransacaoState createState() => _FormularioTransacaoState();
}

class _FormularioTransacaoState extends State<FormularioTransacao> {
  final _tituloController = TextEditingController();
  final _valorController = TextEditingController();
  var _dataSelecionada;

  void _clicarEnviar() {
    final titulo = _tituloController.text;
    final valor = _valorController.text.isEmpty
        ? 0.0
        : double.parse(_valorController.text);

    if (titulo.isEmpty ||
        valor.toString().isEmpty ||
        _dataSelecionada == null) {
      return;
    }

    widget.enviarDados(titulo, valor, _dataSelecionada!);
  }

  Future<void> _mostrarData() async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );

    if (dataSelecionada == null) {
      return;
    }

    setState(() {
      _dataSelecionada = dataSelecionada;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _tituloController,
              onSubmitted: (_) => _clicarEnviar(),
              decoration: const InputDecoration(
                labelText: "Título da Despesa",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              controller: _valorController,
              onSubmitted: (_) => _clicarEnviar(),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Valor (R\$)",
              ),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _dataSelecionada == null
                          ? 'Nenhuma data selecionada'
                          : 'Data selecionada: ${DateFormat('dd/MM/y').format(DateTime.parse(_dataSelecionada.toString()))}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _mostrarData,
                    child: const Text(
                      "Selecionar Data",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _clicarEnviar,
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  child: const Text(
                    "Nova Transação",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:despesas_pessoais/models/transacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transacao> transacoesRecentes;

  const Chart(this.transacoesRecentes, {super.key});

  List<Map<String, Object>> get grupoTransacao {
    return List.generate(7, (index) {
      final diaDaSemana = DateTime.now().subtract(
        Duration(days: index),
      );

      double somaTotal = 0.0;
      for (var i = 0; i < transacoesRecentes.length; i++) {
        bool mesmoDia = transacoesRecentes[i].data.day == diaDaSemana.day;
        bool mesmoMes = transacoesRecentes[i].data.month == diaDaSemana.month;
        bool mesmoAno = transacoesRecentes[i].data.year == diaDaSemana.year;

        if (mesmoDia && mesmoMes && mesmoAno) {
          somaTotal = somaTotal + transacoesRecentes[i].valor;
        }
      }

      return {
        'day': DateFormat.E().format(diaDaSemana)[0],
        'value': somaTotal,
      };
    }).reversed.toList();
  }

  double get _valorTotalSemana {
    return grupoTransacao.fold(0.0, (acc, tr) {
      return acc + double.parse(tr['value'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    grupoTransacao;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grupoTransacao.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: tr['day'].toString(),
                  valor: double.parse(tr['value'].toString()),
                  percentual: _valorTotalSemana == 0.0
                      ? 0.0
                      : double.parse(tr['value'].toString()) /
                          _valorTotalSemana),
            );
          }).toList(),
        ),
      ),
    );
  }
}

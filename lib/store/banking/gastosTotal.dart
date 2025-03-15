import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String total;
  Transaction(this.total);
}

class TransactionTotal {
  Future<Transaction> getTransactions() async {
    try {
      var response = await Dio().get(
        "https://api.juniorbelem.com/list/gastos/total",
      );
      String valorFormatado = NumberFormat(
        "##.00",
      ).format(response.data['total']);
      return Transaction(
        valorFormatado,
      ); 
    } catch (e) {
      print("Erro ao buscar transações: $e");
      return Transaction('0.00'); // Retorno padrão em caso de erro
    }
  }
}

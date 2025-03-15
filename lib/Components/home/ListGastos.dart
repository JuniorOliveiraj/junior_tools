import 'package:animate_do/animate_do.dart';
import 'package:junior_tools/Components/home/CardGastos.dart';
import 'package:flutter/material.dart';
import 'package:junior_tools/store/banking/gastosTotal.dart';

class ListGastos extends StatefulWidget {
  
  @override
  _ListGastosState createState() => _ListGastosState();
}

class _ListGastosState extends State<ListGastos> {
    List<dynamic> _transactions = [
    ['Amazon', 'https://img.icons8.com/color/2x/amazon.png', '6:25pm', '\$8.90'],
    ['Cash from ATM', 'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-atm-banking-and-finance-kiranshastry-lineal-color-kiranshastry.png', '5:50pm', '\$200.00'],
    ['Netflix', 'https://img.icons8.com/color-glass/2x/netflix.png', '2:22pm', '\$13.99'],
    ['Apple Store', 'https://img.icons8.com/color/2x/mac-os--v2.gif', '6:25pm', '\$4.99'],
    ['Cash from ATM', 'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-atm-banking-and-finance-kiranshastry-lineal-color-kiranshastry.png', '5:50pm', '\$200.00'],
    ['Netflix', 'https://img.icons8.com/color-glass/2x/netflix.png', '2:22pm', '\$13.99']
  ];
    String _totalGastos = "Carregando...";

  void fetchTotalGastos() async {
    Transaction transaction = await TransactionTotal().getTransactions();
    setState(() {
      _totalGastos = transaction.total.toString();
    });
  }
  @override
    void initState() {
    fetchTotalGastos();
    super.initState();
  }
  Widget build(BuildContext context) {
    return SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  children: [
                    FadeInDown(
                      duration: Duration(milliseconds: 500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Today', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Text('\$ ${_totalGastos}', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9), fontSize: 16, fontWeight: FontWeight.w700,)),
                        ]
                      ),
                    ),
                    CardGastos(transactions: _transactions),
                  ],
                ),
              ),
            );
  }
}
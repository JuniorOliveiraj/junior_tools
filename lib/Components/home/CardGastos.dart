import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CardGastos extends StatefulWidget {
  final List<dynamic> transactions;

  CardGastos({required this.transactions});

  @override
  _CardGastosState createState() => _CardGastosState();
}

class _CardGastosState extends State<CardGastos> {
  late List<dynamic> _transactions;

  @override
  void initState() {
    super.initState();
    _transactions = widget.transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 20),
        physics: NeverScrollableScrollPhysics(),
        itemCount: _transactions.length,
        itemBuilder: (context, index) {
          return FadeInDown(
            duration: Duration(milliseconds: 500),
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.12),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        _transactions[index][1],
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _transactions[index][0],
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyMedium!.color,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            _transactions[index][2],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    _transactions[index][3],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

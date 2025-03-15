import 'package:flutter/material.dart';

class Buttonradio extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const Buttonradio({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<Buttonradio> createState() => _ButtonradioState();
}

class _ButtonradioState extends State<Buttonradio> {
  // Lista de botões
  List<String> buttonsList = [
    'Ligar PC Local',
    'Ligar PC Remoto',
  ];

  // Mapeamento de rótulos para ícones
  final Map<String, IconData> iconsMap = {
    'Ligar PC Local': Icons.desktop_windows,
    'Ligar PC Remoto': Icons.cloud,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      // largura com o tamanho da tela
      width: MediaQuery.of(context).size.width - 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ...buttonsList.map(
            (e) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: widget.initialValue == e
                      ? const Color.fromARGB(42, 0, 255, 4)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: InkWell(
                splashColor: Colors.transparent, // Remove o efeito splash
                highlightColor:
                    Colors.transparent, // Remove o highlight (pressão)
                onTap: () {
                  widget.onChanged(e);
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: 150, minHeight: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(height: 1),
                      Icon(
                        iconsMap[e], // Ícone associado ao botão
                        size: 30,
                        color: widget.initialValue == e
                            ? const Color.fromARGB(218, 191, 252, 192)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      Text(
                        e,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Radio<String>(
                          value: e,
                          groupValue: widget.initialValue,
                          onChanged: (value) {
                            widget.onChanged(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

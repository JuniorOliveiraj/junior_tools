import 'package:dio/dio.dart';
import 'package:junior_tools/Components/ButtonRadio.dart';
import 'package:junior_tools/theme/export_boiler_plate.dart';

class LigarPc extends StatefulWidget {
  //const LigarPc({super.key, required this.title});

  @override
  State<LigarPc> createState() => _LigarPcState();
}

class _LigarPcState extends State<LigarPc> {
  String selectedValue = 'Ligar PC Local';
  bool Ligado = false;

  void _incrementCounter() {
    setState(() {
      _fetchGastos();
    });
  }

  void _fetchGastos() async {
    try {
      var response = await Dio().get(
        selectedValue == 'Ligar PC Local'
            ? "http://100.64.64.223:3004/wake"
            : "http://local.juniorbelem.com:3004/wake",
      );
      var data = response.data;

      // Alterar o estado de "Ligado" somente após 2 cliques
      if (data == "Pacote Wake-on-LAN enviado com sucesso!") {
        setState(() {
          Ligado = true;
        });
        print(data);
      } else {
        Ligado = false;
        print(data);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Ligar PC'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _incrementCounter();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(30),
                          iconColor:
                              Ligado
                                  ? const Color.fromARGB(255, 0, 255, 4)
                                  : Colors.red,
                        ),
                        child: const Icon(Icons.power_settings_new, size: 130),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        selectedValue,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Buttonradio(
                        initialValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

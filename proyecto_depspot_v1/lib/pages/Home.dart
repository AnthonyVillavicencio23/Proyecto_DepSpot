import 'package:flutter/material.dart';
import 'package:proyecto_depspot_v1/services/openai_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String response = "";
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF343540),
      appBar: AppBar(
        backgroundColor: const Color(0xFF212023),
        centerTitle: true,
        title: const Text("Not Chat GPT"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(106, 158, 158, 158),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(5.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 213, 176, 65),
                ),
                onPressed: () async {
                  var res = await sendTextCompletionRequest(_controller.text);
                  response = res["choices"][0]["message"]["content"];
                  print(response);
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Enviar request", style: TextStyle(fontSize: 24)),
                ),
              ),
              SizedBox(
                width: 500,
                child: Text(
                  response,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

String uri = 'ws://127.0.0.1:8000/wb/ws';

final msg = [];

class TestWebSocket extends StatefulWidget {
  const TestWebSocket({super.key});

  @override
  State<TestWebSocket> createState() => _TestWebSocketState();
}

class _TestWebSocketState extends State<TestWebSocket> {
  late TextEditingController _controller;
  late WebSocketChannel _channel;
  List<String> msg = [];
  @override
  void initState() {
    _controller = TextEditingController();
    _channel = WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8000/wb/ws'));

    _channel.stream.listen((event) {
      setState(() {
        msg.add(event);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Web socket')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),

            // 2. Usamos Expanded para que el ListView no rompa la Column
            Expanded(
              child: ListView.builder(
                itemCount: msg.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(msg[index]));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}

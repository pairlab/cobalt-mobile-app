import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:cobalt/models/user_settings.dart';
import 'package:cobalt/providers/teleoperation_status_provider.dart';

class WebsocketHandler {
  final Ref ref;
  final double publishInterval;
  final String publishFormat;
  WebSocketChannel? channel;
  StreamSubscription? subscription;

  // WebsocketHandler constructor with reference to providers
  WebsocketHandler(this.ref)
      : publishInterval = UserSettings().publishInterval,
        publishFormat = UserSettings().publishFormat;

  // Get connection status from provider
  bool getConnectionStatus() {
    return ref.read(teleopStatusProvider);
  }

  // Update connection status in provider
  void updateConnectionStatus(bool newStatus) {
    ref.read(teleopStatusProvider.notifier).updateStatus(newStatus);
  }

  // Connect to server
  Future<bool> connect(void Function(Uint8List data) handleResponse, String configString) async {
    final host = UserSettings().IPAddress;
    final port = UserSettings().Port;
    final task = UserSettings().task;
    final sessionId = UserSettings().sessionId;

    String queryParams = 'config=$configString';
    if (sessionId.isNotEmpty) {
      queryParams += '&session_id=$sessionId';
    }

    final url = task == 'test'
        ? 'ws://$host:$port/ws?$queryParams'
        : 'ws://$host:$port/$task/ws?$queryParams';

    print('Connecting to WebSocket server: $url');

    try {
      channel = IOWebSocketChannel.connect(
        url,
        connectTimeout: const Duration(seconds: 10),
        pingInterval: const Duration(seconds: 5),
      );

      await channel?.ready;
      print('Connected to WebSocket server.');
      updateConnectionStatus(true);

      subscription = channel?.stream.listen(
        (data) {
          if (data is List<int>) {
            handleResponse(Uint8List.fromList(data));
          } else if (data is String) {
            handleResponse(Uint8List.fromList(data.codeUnits));
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
          close();
        },
        onDone: () {
          print('WebSocket server closed the connection');
          close();
        },
      );

      return true;
    } catch (e) {
      print('Unable to connect: $e');
      updateConnectionStatus(false);
      return false;
    }
  }

  // Disconnect from server
  void close() {
    print('Disconnecting from WebSocket server.');
    updateConnectionStatus(false);
    subscription?.cancel();
    channel?.sink.close();
    ref.invalidateSelf();
    print('Disconnected from WebSocket server.');
  }

  // Publish data to server
  void publish(String type, String data) {
    final Map<String, dynamic> originalData = json.decode(data);
    final Map<String, dynamic> formattedData = {
      'type': type,
      'data': originalData,
    };
    final formattedJsonString = json.encode(formattedData);

    print('Formatted data being sent:');
    print(formattedJsonString);
    channel?.sink.add(formattedJsonString);
  }
}

final websocketHandlerProvider = Provider<WebsocketHandler>((ref) {
  ref.onDispose(() => print('WebsocketHandler Provider disposed.'));
  return WebsocketHandler(ref);
});

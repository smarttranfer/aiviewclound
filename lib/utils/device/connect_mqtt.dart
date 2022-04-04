import 'dart:async';
import 'dart:io';
import 'package:aiviewcloud/models/peer/peer.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

typedef void MqttClientListenCallback(
    List<MqttReceivedMessage<MqttMessage>> messages);

class MqttClientService {
  late MqttClientListenCallback? onUpdates;
  VoidCallback? onReconnect;
  static final MqttClientService _mqttClientService =
      MqttClientService._internal();
  MqttClientService._internal();
  factory MqttClientService() {
    return _mqttClientService;
  }

  late MqttServerClient client;
  late Peer peer;

  Future<void> init(Peer peer) async {
    this.peer = peer;
    String address = peer.transports!.transportInfos![0].data!.connect!.server!
        .replaceAll("mqtt://", "")
        .replaceAll("ws://", "")
        .replaceAll("wss://", "");
    List<String> arr = address.split(":");
    String port = arr.length > 1 ? arr.last : "";
    client = MqttServerClient.withPort(
        arr.first,
        peer.transports!.transportInfos![0].data!.connect!.clientId != null
            ? peer.transports!.transportInfos![0].data!.connect!.clientId!
            : peer.peerId!,
        int.parse(port));
    print("reconnected");

    /// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
    /// for details.
    /// To use websockets add the following lines -:
    /// client.useWebSocket = true;
    /// client.port = 80;  ( or whatever your WS port is)
    /// There is also an alternate websocket implementation for specialist use, see useAlternateWebSocketImplementation
    /// Note do not set the secure flag if you are using wss, the secure flags is for TCP sockets only.
    /// You can also supply your own websocket protocol list or disable this feature using the websocketProtocols
    /// setter, read the API docs for further details here, the vast majority of brokers will support the client default
    /// list so in most cases you can ignore this.
    try {
      /// Set logging on if needed, defaults to off
      client.logging(on: false);

      /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
      client.keepAlivePeriod = 20;

      /// Add the unsolicited disconnection callback
      client.onDisconnected = onDisconnected;

      /// Add the successful connection callback
      client.onConnected = onConnected;

      client.autoReconnect = false;

      /// If you do not want active confirmed subscriptions to be automatically re subscribed
      /// by the auto connect sequence do the following, otherwise leave this defaulted.
      client.resubscribeOnAutoReconnect = false;

      /// Add an auto reconnect callback.
      /// This is the 'pre' auto re connect callback, called before the sequence starts.
      client.onAutoReconnect = onAutoReconnect;

      /// Add an auto reconnect callback.
      /// This is the 'post' auto re connect callback, called after the sequence
      /// has completed. Note that re subscriptions may be occurring when this callback
      /// is invoked. See [resubscribeOnAutoReconnect] above.
      // client.onAutoReconnected = onReconnect;
      client.onSubscribed = onSubscribed;

      /// Set a ping received callback if needed, called whenever a ping response(pong) is received
      /// from the broker.
      client.pongCallback = pong;

      /// Create a connection message to use or use the default one. The default one sets the
      /// client identifier, any supplied username/password and clean session,
      /// an example of a specific one below.
      // final connMess = MqttConnectMessage()
      //     .withClientIdentifier(
      //         peer.transports!.transportInfos![0].data!.connect!.clientId !=
      //                 null
      //             ? peer.transports!.transportInfos![0].data!.connect!.clientId!
      //             : peer.peerId!)
      //     .withWillTopic(
      //         'aiviewcloud') // If you set this you must set a will message
      //     .withWillMessage('My Will message')
      //     .withWillQos(MqttQos.atLeastOnce);
      // print('client connecting....');
      // client.connectionMessage = connMess;

      /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
      /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
      /// never send malformed messages.
      await client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      print('client exception - $e');
      // client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      print('socket exception - $e');
      // client.disconnect();
    }

    // /// Check we are connected
    // if (client.connectionStatus!.state == MqttConnectionState.connected) {
    //   print(' client connected');
    // } else {
    //   /// Use status here rather than state if you also want the broker return code.
    //   print(
    //       'ERROR  client connection failed - disconnecting, status is ${client.connectionStatus}');
    //   client.disconnect();
    // }

    /// Ok, lets try a subscription

    /// The client has a change notifier object(see the Observable class) which we then listen to to get
    /// notifications of published updates to each subscribed topic.

    client.published!.listen((MqttPublishMessage message) {
      print(
          'Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos} ');
    });

    /// If needed you can listen for published messages that have completed the publishing
    /// handshake which is Qos dependant. Any message received on this stream has completed its
    /// publishing handshake with the broker.
    // client.published!.listen((MqttPublishMessage message) {
    //   print(
    //       'Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    // });

    // /// Lets publish to our topic
    // /// Use the payload builder rather than a raw buffer
    // /// Our known topic to publish to
    // const pubTopic = 'Dart/Mqtt_client/testtopic';
    // final builder = MqttClientPayloadBuilder();
    // builder.addString('Hello from mqtt_client');

    // /// Subscribe to it
    // print('Subscribing to the Dart/Mqtt_client/testtopic topic');
    // client.subscribe(pubTopic, MqttQos.exactlyOnce);

    // /// Publish it
    // print('Publishing our topic');
    // client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

    // /// Ok, we will now sleep a while, in this gap you will see ping request/response
    // /// messages being exchanged by the keep alive mechanism.
    // print('Sleeping....');
    // await MqttUtilities.asyncSleep(120);

    // /// Finally, unsubscribe and exit gracefully
    // print('Unsubscribing');
    // client.unsubscribe(topic);

    // /// Wait for the unsubscribe message from the broker if you wish.
    // await MqttUtilities.asyncSleep(2);
    // print('Disconnecting');
    // client.disconnect();
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('Subscription confirmed for topic $topic');
  }

  void removeListener() {
    client.updates!.listen(null);
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('OnDisconnected callback is solicited, this is correct');
    }
  }

  void onConnected() {
    print('OnConnected client callback - Client connection was sucessful ');

    String topic = "";
    Iterable<TransportInfosFunctions> functionList = this
        .peer
        .transports!
        .transportInfos![0]
        .data!
        .functions!
        .where((element) => element.function == 'received');
    if (functionList.isNotEmpty) {
      topic = functionList.first.path!;
    }
    print('Subscribing to the $topic');
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  /// The successful connect callback

  /// The pre auto re connect callback
  void onAutoReconnect() {
    print(
        'onAutoReconnect client callback - Client auto reconnection sequence will start');
  }

  /// The post auto re connect callback
  void onAutoReconnected() {
    print(
        'EXAMPLE::onAutoReconnected client callback - Client auto reconnection sequence has completed');
  }

  /// Pong callback
  void pong() {
    print('Ping response client callback invoked');
  }
}

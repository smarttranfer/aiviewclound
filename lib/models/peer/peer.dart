class Peer {
  String? peerId;
  String? channelId;
  Define? define;
  Functions? functions;
  Transports? transports;
  String? state;
  String? messageId;
  String? version;
  List<String>? peers;
  TargetAuth? targetAuth;

  Peer(
      {this.peerId,
      this.channelId,
      this.define,
      this.functions,
      this.transports,
      this.state,
      this.messageId,
      this.version,
      this.peers,
      this.targetAuth});

  Peer.fromJson(Map<String, dynamic> json) {
    peerId = json['peer_id'] ?? null;
    channelId = json['channel_id'] ?? null;
    define =
        json['define'] != null ? new Define.fromJson(json['define']) : null;
    functions = json['functions'] != null
        ? new Functions.fromJson(json['functions'])
        : null;
    transports = json['transports'] != null
        ? new Transports.fromJson(json['transports'])
        : null;
    state = json['state'] ?? null;
    messageId = json['message_id'] ?? null;
    version = json['version'] ?? null;
    peers = json['peers']?.cast<String>() ?? null;
    targetAuth = json['target_auth'] != null
        ? new TargetAuth.fromJson(json['target_auth'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['peer_id'] = this.peerId;
    data['channel_id'] = this.channelId;
    if (this.define != null) {
      data['define'] = this.define!.toJson();
    }
    if (this.functions != null) {
      data['functions'] = this.functions!.toJson();
    }
    if (this.transports != null) {
      data['transports'] = this.transports!.toJson();
    }
    data['state'] = this.state;
    data['message_id'] = this.messageId;
    data['version'] = this.version;
    data['peers'] = this.peers;
    if (this.targetAuth != null) {
      data['target_auth'] = this.targetAuth!.toJson();
    }
    return data;
  }
}

class Define {
  String? appIdentified;
  String? channelId;
  String? peerId;

  Define({this.appIdentified, this.channelId, this.peerId});

  Define.fromJson(Map<String, dynamic> json) {
    appIdentified = json['appIdentified'];
    channelId = json['channelId'];
    peerId = json['peerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appIdentified'] = this.appIdentified;
    data['channelId'] = this.channelId;
    data['peerId'] = this.peerId;
    return data;
  }
}

class FunctionsDefine {
  String? name;
  List? actions;
  List<String>? transportActions;

  FunctionsDefine({this.name, this.actions, this.transportActions});

  FunctionsDefine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['actions'] != null) {
      actions = <Null>[];
      json['actions'].forEach((v) {
        actions?.add(v);
      });
    }
    transportActions = json['transport_actions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.actions != null) {
      data['actions'] = this.actions?.map((v) => v.toJson()).toList();
    }
    data['transport_actions'] = this.transportActions;
    return data;
  }
}

class Functions {
  List<String>? supported;
  List<FunctionsDefine>? define;

  Functions({this.supported, this.define});

  Functions.fromJson(Map<String, dynamic> json) {
    supported = json['supported'].cast<String>();
    if (json['define'] != null) {
      define = <FunctionsDefine>[];
      json['define'].forEach((v) {
        define?.add(new FunctionsDefine.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supported'] = this.supported;
    if (this.define != null) {
      data['define'] = this.define!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transports {
  TransportsDefine? define;
  List<TransportInfos>? transportInfos;
  List<Channels>? channels;

  Transports({this.define, this.transportInfos, this.channels});

  Transports.fromJson(Map<String, dynamic> json) {
    define = json['define'] != null
        ? new TransportsDefine.fromJson(json['define'])
        : null;
    if (json['transport_infos'] != null) {
      transportInfos = <TransportInfos>[];
      json['transport_infos'].forEach((v) {
        transportInfos?.add(new TransportInfos.fromJson(v));
      });
    }
    if (json['channels'] != null) {
      channels = <Channels>[];
      json['channels'].forEach((v) {
        channels?.add(new Channels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.define != null) {
      data['define'] = this.define!.toJson();
    }
    if (this.transportInfos != null) {
      data['transport_infos'] =
          this.transportInfos!.map((v) => v.toJson()).toList();
    }
    if (this.channels != null) {
      data['channels'] = this.channels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransportsDefine {
  Auth? auth;
  Options? options;
  Options? server;
  Session? session;

  TransportsDefine({this.auth, this.options, this.server, this.session});

  TransportsDefine.fromJson(Map<String, dynamic> json) {
    auth = json['auth'] != null ? new Auth.fromJson(json['auth']) : null;
    options =
        json['options'] != null ? new Options.fromJson(json['options']) : null;
    server =
        json['server'] != null ? new Options.fromJson(json['server']) : null;
    session =
        json['session'] != null ? new Session.fromJson(json['session']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.auth != null) {
      data['auth'] = this.auth!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.toJson();
    }
    if (this.server != null) {
      data['server'] = this.server!.toJson();
    }
    if (this.session != null) {
      data['session'] = this.session!.toJson();
    }
    return data;
  }
}

class Auth {
  String? type;

  Auth({this.type});

  Auth.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class Options {
  Options();

  Options.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class Session {
  String? id;

  Session({this.id});

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class TransportInfos {
  String? id;
  String? type;
  Data? data;

  TransportInfos({this.id, this.type, this.data});

  TransportInfos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Connect? connect;
  List<TransportInfosFunctions>? functions;

  Data({this.connect, this.functions});

  Data.fromJson(Map<String, dynamic> json) {
    connect =
        json['connect'] != null ? new Connect.fromJson(json['connect']) : null;
    if (json['functions'] != null) {
      functions = <TransportInfosFunctions>[];
      json['functions'].forEach((v) {
        functions!.add(new TransportInfosFunctions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.connect != null) {
      data['connect'] = this.connect!.toJson();
    }
    if (this.functions != null) {
      data['functions'] = this.functions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Connect {
  String? server;
  Auth? auth;
  Options? params;
  ConnectOptions? options;
  List<String>? servers;
  String? clientId;

  Connect(
      {this.server,
      this.auth,
      this.params,
      this.options,
      this.servers,
      this.clientId});

  Connect.fromJson(Map<String, dynamic> json) {
    server = json['server'];
    auth = json['auth'] != null ? new Auth.fromJson(json['auth']) : null;
    params =
        json['params'] != null ? new Options.fromJson(json['params']) : null;
    options = json['options'] != null
        ? new ConnectOptions.fromJson(json['options'])
        : null;
    servers = json['servers'].cast<String>();
    clientId = json['client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server'] = this.server;
    if (this.auth != null) {
      data['auth'] = this.auth!.toJson();
    }
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.toJson();
    }
    data['servers'] = this.servers;
    data['client_id'] = this.clientId;
    return data;
  }
}

class ConnectOptions {
  String? transportClientId;

  ConnectOptions({this.transportClientId});

  ConnectOptions.fromJson(Map<String, dynamic> json) {
    transportClientId = json['transport_client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_client_id'] = this.transportClientId;
    return data;
  }
}

class TransportInfosFunctions {
  String? function;
  List? actions;
  List? transportActions;
  String? path;
  String? method;
  Options? options;
  Options? params;

  TransportInfosFunctions(
      {this.function,
      this.actions,
      this.transportActions,
      this.path,
      this.method,
      this.options,
      this.params});

  TransportInfosFunctions.fromJson(Map<String, dynamic> json) {
    function = json['function'];
    if (json['actions'] != null) {
      actions = [];
      json['actions'].forEach((v) {
        actions!.add(v);
      });
    }
    if (json['transport_actions'] != null) {
      transportActions = [];
      json['transport_actions'].forEach((v) {
        transportActions!.add(v);
      });
    }
    path = json['path'];
    method = json['method'];
    options =
        json['options'] != null ? new Options.fromJson(json['options']) : null;
    params =
        json['params'] != null ? new Options.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['function'] = this.function;
    if (this.actions != null) {
      data['actions'] = this.actions!.map((v) => v.toJson()).toList();
    }
    if (this.transportActions != null) {
      data['transport_actions'] =
          this.transportActions!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['method'] = this.method;
    if (this.options != null) {
      data['options'] = this.options!.toJson();
    }
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }
    return data;
  }
}

class Channels {
  String? type;
  String? transport;
  List<String>? functions;
  List? functionActions;

  Channels({this.type, this.transport, this.functions, this.functionActions});

  Channels.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    transport = json['transport'];
    functions = json['functions'].cast<String>();
    if (json['function_actions'] != null) {
      functionActions = [];
      json['function_actions'].forEach((v) {
        functionActions!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['transport'] = this.transport;
    data['functions'] = this.functions;
    if (this.functionActions != null) {
      data['function_actions'] =
          this.functionActions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TargetAuth {
  String? type;
  TargetAuthData? data;

  TargetAuth({this.type, this.data});

  TargetAuth.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data =
        json['data'] != null ? new TargetAuthData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TargetAuthData {
  Options? token;
  Client? client;

  TargetAuthData({this.token, this.client});

  TargetAuthData.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? new Options.fromJson(json['token']) : null;
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

class Client {
  String? clientId;
  String? clientCredential;
  int? expireIn;

  Client({this.clientId, this.clientCredential, this.expireIn});

  Client.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    clientCredential = json['client_credential'];
    expireIn = json['expire_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['client_credential'] = this.clientCredential;
    data['expire_in'] = this.expireIn;
    return data;
  }
}

// class Define {
// 	Auth auth;
// 	Options options;
// 	Options server;
// 	Session session;

// 	Define({this.auth, this.options, this.server, this.session});

// 	Define.fromJson(Map<String, dynamic> json) {
// 		auth = json['auth'] != null ? new Auth.fromJson(json['auth']) : null;
// 		options = json['options'] != null ? new Options.fromJson(json['options']) : null;
// 		server = json['server'] != null ? new Options.fromJson(json['server']) : null;
// 		session = json['session'] != null ? new Session.fromJson(json['session']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.auth != null) {
//       data['auth'] = this.auth.toJson();
//     }
// 		if (this.options != null) {
//       data['options'] = this.options.toJson();
//     }
// 		if (this.server != null) {
//       data['server'] = this.server.toJson();
//     }
// 		if (this.session != null) {
//       data['session'] = this.session.toJson();
//     }
// 		return data;
// 	}
// }

// class Connect {
// 	String server;
// 	Auth auth;
// 	Options params;
// 	Options options;
// 	List<String> servers;
// 	String clientId;

// 	Connect({this.server, this.auth, this.params, this.options, this.servers, this.clientId});

// 	Connect.fromJson(Map<String, dynamic> json) {
// 		server = json['server'];
// 		auth = json['auth'] != null ? new Auth.fromJson(json['auth']) : null;
// 		params = json['params'] != null ? new Options.fromJson(json['params']) : null;
// 		options = json['options'] != null ? new Options.fromJson(json['options']) : null;
// 		servers = json['servers'].cast<String>();
// 		clientId = json['client_id'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['server'] = this.server;
// 		if (this.auth != null) {
//       data['auth'] = this.auth.toJson();
//     }
// 		if (this.params != null) {
//       data['params'] = this.params.toJson();
//     }
// 		if (this.options != null) {
//       data['options'] = this.options.toJson();
//     }
// 		data['servers'] = this.servers;
// 		data['client_id'] = this.clientId;
// 		return data;
// 	}
// }

// class Functions {
// 	String function;
// 	List<Null> actions;
// 	List<Null> transportActions;
// 	String path;
// 	String method;
// 	Options options;
// 	Options params;

// 	Functions({this.function, this.actions, this.transportActions, this.path, this.method, this.options, this.params});

// 	Functions.fromJson(Map<String, dynamic> json) {
// 		function = json['function'];
// 		if (json['actions'] != null) {
// 			actions = new List<Null>();
// 			json['actions'].forEach((v) { actions.add(new Null.fromJson(v)); });
// 		}
// 		if (json['transport_actions'] != null) {
// 			transportActions = new List<Null>();
// 			json['transport_actions'].forEach((v) { transportActions.add(new Null.fromJson(v)); });
// 		}
// 		path = json['path'];
// 		method = json['method'];
// 		options = json['options'] != null ? new Options.fromJson(json['options']) : null;
// 		params = json['params'] != null ? new Options.fromJson(json['params']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['function'] = this.function;
// 		if (this.actions != null) {
//       data['actions'] = this.actions.map((v) => v.toJson()).toList();
//     }
// 		if (this.transportActions != null) {
//       data['transport_actions'] = this.transportActions.map((v) => v.toJson()).toList();
//     }
// 		data['path'] = this.path;
// 		data['method'] = this.method;
// 		if (this.options != null) {
//       data['options'] = this.options.toJson();
//     }
// 		if (this.params != null) {
//       data['params'] = this.params.toJson();
//     }
// 		return data;
// 	}
// }

// class Data {
// 	Options token;
// 	Client client;

// 	Data({this.token, this.client});

// 	Data.fromJson(Map<String, dynamic> json) {
// 		token = json['token'] != null ? new Options.fromJson(json['token']) : null;
// 		client = json['client'] != null ? new Client.fromJson(json['client']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.token != null) {
//       data['token'] = this.token.toJson();
//     }
// 		if (this.client != null) {
//       data['client'] = this.client.toJson();
//     }
// 		return data;
// 	}
// }

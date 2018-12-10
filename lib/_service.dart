import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mma_poll/model.dart';

//application unique id
const String _applicationUniqueId = "app_id";

//mobile unique id
String _deviceUniqueId = "";

//token key
const String _tokenKey = "token";

//Server url
const String _serverUrl = 'http://10.151.135.207:3000';

//Note final, its init only once
final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

//Mutable
Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

Future<String> _getDeviceId() async {
  if (_deviceUniqueId == "") {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidDeviceInfo = await _deviceInfo.androidInfo;
        _deviceUniqueId = "${androidDeviceInfo.device}-${androidDeviceInfo.id}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await _deviceInfo.iosInfo;
        _deviceUniqueId =
            "${iosDeviceInfo.model}-${iosDeviceInfo.identifierForVendor}";
      }
    } on PlatformException {
      _deviceUniqueId = "unknown";
    } catch (error) {
      throw error;
    }
  }
  return _deviceUniqueId;
}

//Get the tokens from Shared Preferences.
Future<String> _getDeviceToken() async {
  final SharedPreferences sharedPreferences = await _sharedPreferences;
  return sharedPreferences.getString(_tokenKey);
}

//Save the token from server to Shared Preferences.
Future<bool> saveDeviceToken(String token) async {
  final SharedPreferences sharedPreferences = await _sharedPreferences;
  return sharedPreferences.setString(_tokenKey, token);
}

//--------------HTTP Communication by order------------

//---Posts
Future<Map<String, dynamic>> register(Map<String, dynamic> post) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.post(
      _serverUrl + '/register',
      headers: {
        'device-id': _deviceId,
        'token': _token,
        'app-id': _applicationUniqueId,
        'Accept': 'application/json'
      },
      body: post,
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    }
  } catch (error) {
    throw error;
  }
  return data;
}

Future<Map<String, dynamic>> login(Map<String, dynamic> post) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.post(
      _serverUrl + '/register',
      headers: {
        'device-id': _deviceId,
        'token': _token,
        'app-id': _applicationUniqueId,
        'Accept': 'application/json'
      },
      body: post,
    );

    if (response.statusCode == 200) {
      //User id and token are recieved here. Store them if they do exist
      data = jsonDecode(response.body);
    } else {
      data = null;
    }
  } catch (error) {
    throw error;
  }
  return data;
}

Future<Map<String, dynamic>> createPoll(Map<String, dynamic> post) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.post(
      _serverUrl + '/auth/create-poll',
      headers: {
        'device-id': _deviceId,
        'token': _token,
        'app-id': _applicationUniqueId,
        'Accept': 'application/json'
      },
      body: post,
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      data = null;
    }
  } catch (error) {
    throw error;
  }
  return data;
}

//---Updates

Future<Map<String, dynamic>> changePassword(Map<String, dynamic> update) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.put(
      _serverUrl + '/auth/change-password',
      headers: {
        'device-id': _deviceId,
        'token': _token,
        'app-id': _applicationUniqueId,
        'Accept': 'application/json'
      },
      body: update,
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      data = null;
    }
  } catch (error) {
    throw error;
  }
  return data;
}

Future<Map<String, dynamic>> editProfile(
    Map<String, dynamic> update, int userId) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.put(
      _serverUrl + '/auth/users/$userId/edit-profile',
      headers: {
        'device-id': _deviceId,
        'token': _token,
        'app-id': _applicationUniqueId,
        'Accept': 'application/json'
      },
      body: update,
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      data = null;
    }
  } catch (error) {
    throw error;
  }
  return data;
}

Future<Map<String, dynamic>> vote(
    Map<String, dynamic> update, int pollId) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.put(
      _serverUrl + '/auth/polls/$pollId/vote',
      headers: {
        'device-id': _deviceId,
        'token': _token,
        'app-id': _applicationUniqueId,
        'Accept': 'application/json'
      },
      body: update,
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      data = null;
    }
  } catch (error) {
    throw error;
  }
  return data;
}

Future<Map<String, dynamic>> closePoll(
    Map<String, dynamic> update, int pollId) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.put(
      _serverUrl + '/auth/polls/$pollId/close-poll',
      headers: {
        'device-id': _deviceId,
        'token': _token,
        'app-id': _applicationUniqueId,
        'Accept': 'application/json'
      },
      body: update,
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      data = null;
    }
  } catch (error) {
    throw error;
  }
  return data;
}

//---Get

Future<AccountModel> viewProfile(int id) async {
  AccountModel user;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/users/$id/view-profile', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      user = AccountModel.fromJson(json['result']);
    }
  } catch (error) {
    throw error;
  }
  return user;
}

Future<List<PollModel>> getPolls() async {
  List<PollModel> polls = new List();
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/polls', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (json['success']) {
        for (dynamic j in json['result']) {
          PollModel poll = PollModel.fromJson(j);
          polls.add(poll);
        }
      } else {
        PollModel poll = PollModel.fromJson(json['result']);
        polls.add(poll);
      }
    }
  } catch (error) {
    throw error;
  }
  return polls;
}

Future<List<NotificationModel>> getNotifications(int userId) async {
  List<NotificationModel> notifications = new List();
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/notifications/$userId', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (json['success'])
        for (dynamic j in json['result']) {
          NotificationModel notification = NotificationModel.fromJson(j);
          notifications.add(notification);
        }
      else {
        NotificationModel notification =
            NotificationModel.fromJson(json['result']);
        notifications.add(notification);
      }
    }
  } catch (error) {
    throw error;
  }
  return notifications;
}

Future<PollModel> getPoll(String pollId) async {
  int pollIntId = int.parse(pollId);
  PollModel poll;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/polls/$pollIntId', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      poll = PollModel.fromJson(json);
    }
  } catch (error) {
    throw error;
  }
  return poll;
}

Future<List<CommentModel>> getParentComments() async {
  List<CommentModel> comments = new List();
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/parent-comments', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (json['success'])
        for (dynamic j in json['result']) {
          CommentModel comment = CommentModel.fromJson(j);
          comments.add(comment);
        }
      else {
        CommentModel comment = CommentModel.fromJson(json['result']);
        comments.add(comment);
      }
    }
  } catch (error) {
    throw error;
  }
  return comments;
}

Future<CommentModel> getCommenter(int userId) async {
  CommentModel poll;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response = await http
        .get(_serverUrl + '/all-comments/$userId/commenter', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      poll = CommentModel.fromJson(json);
    }
  } catch (error) {
    throw error;
  }
  return poll;
}

Future<List<CommentModel>> getReplies(int parentId) async {
  List<CommentModel> comments = new List();
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/replies/$parentId', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (json['success'])
        for (dynamic j in json['result']) {
          CommentModel comment = CommentModel.fromJson(j);
          comments.add(comment);
        } //Moleton gala of the time of India
      else {
        //The moleton dynamic of the time in India will be remembered in the place of all the fighting neighbors as the best in the world
        CommentModel comment = CommentModel.fromJson(json['result']);
        comments.add(comment);
      }
    }
  } catch (error) {
    throw error;
  }
  return comments;
}

Future<AccountModel> getNotificationUser(int userFromId) async {
  AccountModel account;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();

    final http.Response response = await http
        .get(_serverUrl + '/get-notification-user/$userFromId', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      if (json['success'])
        account = AccountModel.fromJson(json['result']);
      else
        account = json['result'];
    }
  } catch (error) {
    throw error;
  }
  return account;
}

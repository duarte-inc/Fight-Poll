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
const String _serverUrl = 'http://10.159.133.152:3000';

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
        print(_deviceUniqueId);
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

//Account
//Poll
//Comments
//Notifications

//Order: p,u,g,d

//--------> Account-------->Account------->Account------>

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
    } else {
      data = null;
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

//---Get

Future<AccountModel> viewProfile(int id) async {
  AccountModel user;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/auth/users/$id', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      user = AccountModel.fromJson(json);
    }
  } catch (error) {
    throw error;
  }
  return user;
}

//--------> Poll-------->Poll------->Poll------>

//---Posts
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
Future<PollModel> getPolls() async {
  PollModel poll;
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
      poll = PollModel.fromJson(json);
    }
  } catch (error) {
    throw error;
  }
  return poll;
}

Future<PollModel> getPoll(int pollId) async {
  PollModel poll;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/polls/$pollId', headers: {
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

//-------->Comment-------->Comment------->Comment------>

//---Posts

Future<Map<String, dynamic>> postReply(Map<String, dynamic> post) async {
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

Future<Map<String, dynamic>> postParentComment(
    Map<String, dynamic> post) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.post(
      _serverUrl + '/auth/post-parent-comment',
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

Future<Map<String, dynamic>> likeAComment(
    Map<String, dynamic> update, int commentId) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.put(
      _serverUrl + '/auth/all-comments/:$commentId/like',
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

//---Gets
Future<CommentModel> getParentComment() async {
  CommentModel poll;
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
      poll = CommentModel.fromJson(json);
    }
  } catch (error) {
    throw error;
  }
  return poll;
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

Future<CommentModel> getReplies(int parentId) async {
  CommentModel poll;
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
      poll = CommentModel.fromJson(json);
    }
  } catch (error) {
    throw error;
  }
  return poll;
}

//------>Notification------>Notification----->Notification---->

//---Posts
Future<Map<String, dynamic>> replyNotification(
    Map<String, dynamic> post) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.post(
      _serverUrl + '/auth/post-reply-notification',
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

Future<Map<String, dynamic>> pollNotification(Map<String, dynamic> post) async {
  dynamic data;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    //server res
    final http.Response response = await http.post(
      _serverUrl + '/auth/post-poll-notification',
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

//--Get
Future<NotificationModel> getNotification(int userId) async {
  NotificationModel notification;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response =
        await http.get(_serverUrl + '/auth/notifications/$userId', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      notification = NotificationModel.fromJson(json);
    }
  } catch (error) {
    throw error;
  }
  return notification;
}

Future<NotificationModel> getNotificationUser(int userId) async {
  NotificationModel notification;
  try {
    String _deviceId = await _getDeviceId();
    String _token = await _getDeviceToken();
    final http.Response response = await http
        .get(_serverUrl + '/auth/get-notification-username/$userId', headers: {
      "device-id": _deviceId,
      "token": _token,
      "app-id": _applicationUniqueId,
    });
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      notification = NotificationModel.fromJson(json);
    }
  } catch (error) {
    throw error;
  }
  return notification;
}

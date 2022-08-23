import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:socket_login_demo/core/app_constants.dart';
import 'package:socket_login_demo/models/data_request.dart';
import 'package:socket_login_demo/models/input_service_body.dart';
import 'package:socket_login_demo/models/request_mesage.dart';
import 'package:socket_login_demo/services/base_services.dart';
import 'package:socket_login_demo/utils/data/null_extensions.dart';

class SocketServices extends BaseServices {
  static SocketServices? _instance;

  factory SocketServices() => _instance ??= SocketServices._();

  Map<String, RequestedMessage> requestedMessages = {};

  SocketServices._() : super(AppConst.socketServicePath) {
    //-- Nhận thông báo hệ thống
    socket.on('SYS_MSG', (data) {
      print('system message: $data');
    });

    //-- Nhận phản hồi của server cho một request thông thường
    socket.on('RES_MSG', (data) {
      print('response message: $data');
      handleResponse(data);
    });

    //-- Nhận dữ liệu notify
    socket.on('NTF_MSG', (data) {
      print('notify message: $data');
    });
  }

  Future<dynamic> sendRequest(String workerName, String serviceName,
      String operation, inputParams, DataRequest request,
      {timeOut = 15}) async {
    var clientSeq = getClientSeq();

    var otherInfo = {};
    otherInfo['AppLoginID'] = request.headers?.token?.ud?.u;
    otherInfo['AppLoginPswd'] = '';
    otherInfo['SessionID'] = request.headers?.token?.ud?.sid;
    otherInfo['OTP'] = '';
    otherInfo['AprStat'] = 'N';
    otherInfo['AprSeq'] = '';
    otherInfo['MakerDt'] = '';

    final data = jsonEncode(InputServiceBody(
      appLoginID: request.headers?.token?.ud?.u,
      appLoginPswd: '',
      sessionID: request.headers?.token?.ud?.sid,
      otp: '',
      aprStat: 'N',
      aprSeq: '',
      makerDt: '',
      clientSeq: clientSeq,
      serviceName: serviceName,
      workerName: workerName,
      operation: operation,
      inVal: inputParams,
      totInVal: inputParams.length,
      timeOut: timeOut,
    ));

    print('send: $data');
    socket.emit('REQ_MSG', data);

    Completer c = Completer();
    requestedMessages[clientSeq.toString()] = RequestedMessage(c);

    inspect(requestedMessages);

    return c.future;
  }

  handleResponse(Map<String, dynamic> msg) {
    var result = msg['Result'];
    var clientSeq = msg['ClientSeq'];

    final request = requestedMessages[clientSeq];

    if (request == null) {
      return;
    }
    try {
      var messageCode = msg["Code"];
      var messageText = msg["Message"];

      if (messageCode ==
                  '010021' || // OTP đã được gửi về số điện thoại và email của Quý khách -> trường hợp này không coi là lỗi
              messageCode ==
                  '010010' // Password is expired or reset -> need to show form enter new password
          ) {
        return '1';
      }

      if (result == '0') {
        request.completer.completeError(messageText);
        requestedMessages.remove(clientSeq);
      } else if (result == '1') {
        var packageIndex = msg["Packet"];
        var responseBody = msg["Data"];

        if (isNotBlank(request.data)) {
          request.data = request.data! + responseBody;
        } else {
          request.data = responseBody;
        }

        if (int.parse(packageIndex) <= 0) {
          if (isNotBlank(request.data)) {
            request.completer.complete(request.data!);
          } else {
            request.completer.complete(null);
          }
          requestedMessages.remove(clientSeq);
        }
      }
    } catch (error) {
      print(error.toString());
    }
  }
}

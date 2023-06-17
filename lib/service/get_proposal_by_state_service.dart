import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/get_proposals_by_state.dart';
import '../storage/jwt_storage.dart';

class getProposalListService {
  static const String _url =
      "https://test.satta.biz/api/v1/proposals_by_state.json?proposal_state='pending','replied','proposal_stvs'";

  Future<List<GetProposalModel>> getProposalListData() async {
    final dio = Dio();
    dio.options.responseType = ResponseType.json;
    List<GetProposalModel> _list = [];
    final _jwt = await jwtStorageService().getJwtData();
    debugPrint(_jwt);
    var response = await dio.get(
      _url,
      options: Options(
        headers: {
          "Authorization": _jwt,
        },
      ),
    );
    debugPrint('aaaaaaa${response.data['status'].toString()}');
    List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(response.data['proposals']);

//for data control
/* if (data == null || data.isEmpty) {
print('No proposals found.');
} else {proposal
for (var proposal in data) {
// Do something with each proposal
print(proposal);
}
} */

    data.forEach((element)  {
      GetProposalModel getOrderlistModel =
           GetProposalModel.fromMap(element);
      _list.add(getOrderlistModel);
    });
    debugPrint('first order.. ${_list.toList()}');
    GetProposalModel firstOrder = _list[0];
    debugPrint('first order.. ${firstOrder.productProposals.toString()}');

    return _list;
  }
}

controllerTemplate() {
  return """
import 'package:flutter/material.dart';
import 'package:playground/helpers/api.dart';
import 'package:playground/helpers/state_util.dart';

import '../data/@filename_repository.dart';
import '../data/@filenameModel.dart';
import '../views/@filename_add_view.dart';
import '../views/@filename_detail_view.dart';
import '../views/@filename_view.dart';

class @classNameController extends State<@classNameView> {
  static late @classNameController instance;
  late @classNameView view;

  var error = '';
  var connectionStatus = ConnectionStatus.loading;
  var data = <@modelName>[];

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  @override
  void initState() {
    instance = this;
    super.initState();

    getData();
  }

  getData() {
    data.clear();
    setState(() {
      connectionStatus = ConnectionStatus.loading;
    });
    @classNameRepository().getData(
      onSuccess: (respon) {
        setState(() {
          data.addAll(respon.listData as List<@modelName>);
          if (data.isEmpty) {
            connectionStatus = ConnectionStatus.error;
            error = "No data found";
          } else {
            connectionStatus = ConnectionStatus.done;
          }
        });
      },
      onError: (err) {
        setState(() {
          connectionStatus = ConnectionStatus.error;
          error = err.toString();
        });
      },
    );
  }

  toDetail(int id) {
    Get.to(
      @classNameDetailView(id: id),
    );
  }

  addData() {
    Get.to(const @classNameAddView());
  }
}


""";
}

controllerDetailTemplate() {
  return """
import 'package:@packageName/helpers/api.dart';
import 'package:@packageName/helpers/state_util.dart';
import 'package:@packageName/helpers/widgets/dialog_confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data/@modelImport.dart';
import '../data/@filename_repository.dart';
import '../views/@filename_add_view.dart';
import '../views/@filename_detail_view.dart';
import '../views/@filename_view.dart';

class @classNameDetailController extends State<@classNameDetailView> {
  static late @classNameDetailController instance;
  late @classNameDetailView view;

  var error = '';
  var connectionStatus = ConnectionStatus.loading;
  late int id;
  @modelName? @varName;

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  @override
  void initState() {
    instance = this;
    id = widget.id;
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      connectionStatus = ConnectionStatus.loading;
    });
    @classNameRepository().getDetail(
      id,
      onSuccess: (respon) {
        setState(() {
          @varName = respon.data as @modelName;
          connectionStatus = ConnectionStatus.done;
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

  editData() {
    Get.to(
      @classNameAddView(id: id),
    );
  }

  confirmDelete() {
    dialogConfirm(
      onConfirm: () {
        delete();
      },
      msg: "Are sure want delete  \${@varName!.name} ?",
      confirmColor: Colors.red[300],
      textConfirm: "Delete",
    );
  }

  void delete() async {
    EasyLoading.show();
    @classNameRepository().delete(id, onSuccess: (respon) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess(respon.message!);
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(const @classNameView());
      });
    }, onError: (error) {
      EasyLoading.dismiss();
      EasyLoading.showError(error.toString());
    });
  }
}

""";
}

controllerAddTemplate() {
  return """
import 'dart:io';

import 'package:@packageName/helpers/state_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../data/@filenameModel.dart';
import '../data/@filename_repository.dart';
import '../views/@filename_add_view.dart';

import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio;

import '../views/@filename_detail_view.dart';
import '../views/@filename_view.dart';

class @classNameAddController extends State<@classNameAddView> {
  static late @classNameAddController instance;
  late @classNameAddView view;

  final formKey = GlobalKey<FormState>();

  bool isEdit = false;
  int? id;
  @modelName? @varName;

  @varInput

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  @override
  void initState() {
    instance = this;
    if (widget.id != null) {
      id = widget.id;
      isEdit = true;
      getData();
    }
    super.initState();
  }

  setId(int v) {
    setState(() {
      id = v;
    });
    getData();
  }

  getData() {
    EasyLoading.show();
    @classNameRepository().getDetail(
      id!,
      onSuccess: (respon) {
        EasyLoading.dismiss();
        setState(() {
          @varName = respon.data as @modelName;
        });
        setData();
      },
      onError: (err) {
        EasyLoading.dismiss();
        EasyLoading.showError(err.toString());
      },
    );
  }

  @varImageInput

  save() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (!isValid) return;
    formKey.currentState!.save();

    final params = <String, dynamic>{
      @varParameters
    };

    @varUploadFile

    String url = '@varApi';
    if (isEdit) {
      params['_method'] = 'put';
      url += '/\$id';
    }

    EasyLoading.show();
    final formData = dio.FormData.fromMap(params);
    @classNameRepository().save(
      url,
      formData,
      onSuccess: (respon) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess(respon.message!);

        Future.delayed(const Duration(seconds: 1), () {
          if (isEdit) {
            Get.off(@classNameDetailView(
              id: id!,
            ));
          } else {
            Get.off(const @classNameView());
          }
        });
      },
      onError: (error) {
        EasyLoading.dismiss();
        EasyLoading.showError(error.toString());
      },
    );
  }

  void setData() {
    if (@varName != null) {
      @varSetText
    }
  }

  @override
  void dispose() => super.dispose();
}
""";
}

responseData() {
  return """
class ResponseData {
  int? page;
  int? totalPage;
  int? totalData;
  String? message;
  dynamic data;
  List<dynamic>? listData;

  ResponseData({
    this.page,
    this.totalPage,
    this.totalData,
    this.message,
    this.data,
    this.listData,
  });
}

""";
}

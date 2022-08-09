class ApiResponse {
  ApiResponse({
    this.statusCode = 500,
    Map<String, dynamic>? data,
  }) {
    this.data = data ?? <String, dynamic>{};
  }

  int statusCode;
  Map<String, dynamic> data = <String, dynamic>{};

  bool isSuccess() => statusCode == 200;

  bool existData() => data.isNotEmpty;

  bool isAllPass() => isSuccess() && existData();
}

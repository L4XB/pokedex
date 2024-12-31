import 'dart:io';

import 'package:dio/dio.dart';

class ClassificationRepository {
  Future<String> classifiyImage(File file) async {
    final Response response;
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    response = await Dio()
        .post("http://127.0.0.1:8000/api/classification", data: formData);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data["predicted_class"];
    }
    return "";
  }
}

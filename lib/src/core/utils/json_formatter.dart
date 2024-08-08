import 'dart:convert';

String prettyJsonFromString(String data) {
  Map<String,dynamic> json = jsonDecode(data);
  return _formatJson(json);
}

String prettyJson(Map<String,dynamic> data){
  return _formatJson(data);
}

String _formatJson(dynamic jsonObject, {int indent = 0}) {
  String prettyString = "";
  if (jsonObject is Map) {
    prettyString += "{\n";
    int index = 0;
    jsonObject.forEach((key, value) {
      if (value is String) {
        prettyString += "${" " * (indent + 2)}\"$key\": \"$value\"";
      } else {
        prettyString +=
        "${" " * (indent + 2)}\"$key\": ${_formatJson(value, indent: indent + 2)}";
      }
      if (index < jsonObject.length - 1) {
        prettyString += ",\n";
      } else {
        prettyString += "\n";
      }
      index++;
    });
    prettyString += "${" " * indent}}";
  } else if (jsonObject is List) {
    prettyString += "[\n";
    for (var i = 0; i < jsonObject.length; i++) {
      prettyString +=
      "${" " * (indent + 2)}${_formatJson(jsonObject[i], indent: indent + 2)}";
      if (i < jsonObject.length - 1) {
        prettyString += ",\n";
      } else {
        prettyString += "\n";
      }
    }
    prettyString += "${" " * indent}]";
  } else {
    prettyString += jsonObject.toString();
  }
  return prettyString;
}
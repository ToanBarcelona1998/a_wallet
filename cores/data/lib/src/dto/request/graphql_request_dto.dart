abstract class GraphqlRequestDto{
  const GraphqlRequestDto();

  Map<String,dynamic> variables();

  String query();

  String operationName();

  Map<String,dynamic> toMap(){
    return {
      'variables': variables(),
      'query': query(),
      'operationName': operationName(),
    };
  }
}
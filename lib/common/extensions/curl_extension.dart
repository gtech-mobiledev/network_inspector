import 'package:http/http.dart' as http;

extension CurlCommand on http.BaseRequest {
  /// Converts the HTTP request to a cURL command
  String toCurlCommand() {
    final curlCmd = StringBuffer();

    // Add basic curl command with URL and method
    curlCmd.write('curl -X ${method.toUpperCase()} "${url.toString()}"');

    // Add headers to the cURL command
    headers.forEach((key, value) {
      curlCmd.write(' -H "$key: $value"');
    });

    // Add body for POST, PUT, PATCH requests
    if (this is http.Request) {
      final request = this as http.Request;
      if (request.body.isNotEmpty) {
        curlCmd.write(' -d \'${request.body}\'');
      }
    }

    return curlCmd.toString();
  }
}

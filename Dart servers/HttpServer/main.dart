import "dart:io";
import "dart:convert";

List taskData = [
	{
		"task": "Work on Dart Server",
		"completed": false,
	},
	{
		"task": "Edit Videos",
		"completed": false,
	},
];

void main() async {
	var addr = "127.0.0.1";
	var port = 3000;
	var server = await HttpServer.bind(addr, port);
	print("Starting server at $addr:$port");

	server.listen((HttpRequest req) {
		// Print request URI.
		print(req.uri);

		// Handle routing through switch statement.
		switch (req.uri.toString()) {
			case "/":
				// Request from "/" (index) route. Pass to homeRouter
				// function.
				homeRouter(req);
				break;
			case "/addTask":
				// Request from "/addTask" route. Pass to addTaskRouter
				// function.
				homeRouter(req);
				break;
			default:
				if (req.uri.toString().startsWith("/addTask")) {
					addTask(req);
					break;
				}
		}
	});
}

homeRouter(HttpRequest req) {
	// Encode taskData to JSON.
	var encoded = jsonEncode(taskData);

	// Change response header. Content type is application/json.
	// Charset is UTF-8.
	req.response.headers.contentType = new ContentType("application", "json", charset: "utf-8");

	// Respond back "Hi".
	req.response.write("Hi");

	// Respond back with JSON encoded taskData.
	req.response.write(encoded);

	// Close Resonse.
	req.response.close();
}

addTask(HttpRequest req) {
	// Parse query string.
	var uri = Uri.parse(req.uri.toString());
	print(uri.queryParameters["task"]);

	// Add new task to task data list.
	var data = {
		"task": uri.queryParameters["task"],
		"completed": false
	};
	taskData.add(data);

	// Redirect to homeRouter.
	Uri redirectUri = Uri.http("localhost:3000", "/");
	req.response.redirect(redirectUri);
}
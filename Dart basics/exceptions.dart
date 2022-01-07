void main() {
	var name = "Voyager I";
	var year = 1977;
	var antennaDiameter = 3.7;
	var flybyObjects = ["Jupiter", "Saturn", "Uranus", "Neptune"];
	var image = {
		"tags": ["Saturn"],
		"url": "//path/to/saturn.jpg"
	};

	// Exceptions
	// To raise an exception, use throw:
	if (astronauts == 0) {
		throw StateError("No astronauts");
	}

	// To catch an exception, use a try statement with on or catch (or
	// both):
	try {
		for (final object in FlybyObjects) {
			var description = await File("$object.txt").readAsString();
			print(description);
		}
	} on IOException catch (e) {
		print("Could not describe object: $e");
	} finally {
		flybyObjects.clear();
	}

	// Note that the code above is asynchronous; try works for both
	// synchronous code and code in an async function.
	// Read more about exceptions, including stack traces, rethrow, and
	// the difference between Error and Exception.
}
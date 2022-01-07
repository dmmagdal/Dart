void main() {
	var name = "Voyager I";
	var year = 1977;
	var antennaDiameter = 3.7;
	var flybyObjects = ["Jupiter", "Saturn", "Uranus", "Neptune"];
	var image = {
		"tags": ["Saturn"],
		"url": "//path/to/saturn.jpg"
	};

	// Dart supports the usual control flow statements.
	if (year >= 2001) {
		print("21st century");
	} else if (year >= 1901) {
		print("20th century");
	}

	for (final object in flybyObjects) {
		print(object);
	}

	for (int month = 1; month <= 12; month++) {
		print(month);
	}

	while (year < 2016) {
		year += 1;
	}

	// Read more about control flow statements in Dart, including break
	// and continue, switch and case, and assert.
}
void main() {
	var name = "Voyager I";
	var year = 1977;
	var antennaDiameter = 3.7;
	var flybyObjects = ["Jupiter", "Saturn", "Uranus", "Neptune"];
	var image = {
		"tags": ["Saturn"],
		"url": "//path/to/saturn.jpg"
	};

	var result = fibonacci(20);

	// A shorthand => (arrow) syntax is handy for functions that
	// contain a single statement. This syntax is especially useful
	// when passing anonymous functions as arguments.
	flybyObjects.where((name) => name.contains("turn")).forEach(print);

	// Besides showing an anonymous function (the argument to where()),
	// this code shows that you can use a function as an argument: the
	// top-level print() function is an argument to forEach(). Read
	// more about functions in Dart, including optional parameters,
	// default paramter values, and lexical scope.

	// Comments
	// Dart comments usually start wil //.
	// This is a normal, one-line comment.
	/// This is a documentation comment, used to document libraries,
	/// classes, and their members. Tools like IDEs and dartdoc treat
	/// doc comments specially.
	/* Comments like these are also supported */
	// Read more about comments in Dart, including how the
	// documentation tooling works.
}


// It is recommended to specifying the types of each function's
// arguments and return value.
int fibonacci(int n){
	if (n == 0 || n == 1) return n;
	return fibonacci(n - 1) + fibonacci(n - 2);
}
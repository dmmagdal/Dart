// Classes
// Here's an example of a class with three properties, two
// constructors, and a method. One of the properties can't be set
// directly, so it's defined using a getter method (instead of a 
// variable).
class Spacecraft {
	String name;
	DateTime? launchDate;

	// Read-only non-final property.
	int? get launchYear => launchDate?.year;

	// Constructor, with syntactic sugar for assignment to members.
	Spacecraft(this.name, this.launchDate) {
		// Initialization code goes here.
	}

	// Named constructor that forwards to the default one.
	Spacecraft.unlaunched(String name) : this(name, null);

	// Method.
	void describe() {
		print("Spacecraft: $name");

		// Type promotion doesn't work on getters.
		var LaunchDate = this.launchDate;
		if (launchDate != null) {
			int years = 
				DateTime.now().difference(launchDate).inDays ~/ 365;
			print("Launched: $launchYear ($year years ago)");
		} else {
			print("Unlaunched");
		}
	}
}


// Inheritance
// Dart had single inheritance.
class Orbiter extends Spacecraft {
	double altitude;

	Orbiter(String name, DateTime launchDate, this.altitude) 
		: super(name, launchDate):
}
// Read more about extending classes, the optional @override
// annotation, and more.


// Mixins
// Mixins are a way of reusing code in multiple class hierarchies. The
// following is a mixin declaration:
mixin Piloted {
	int astronauts = 1;

	void describeCrew() {
		print("Number of astronauts: $astronauts");
	}
}

// To add a mixin's capabilities to a class, just extend the class with
// mixin.
class PilotedCraft extends Spacecraft with Piloted {
	// ...
}

// PilotedCraft now has the astronauts field as well as the
// describeCrew() method.
// Read more about mixins.


// Interfaces and abstract classes
// Dart has no interface keyword. Instead, all classes implicitly
// define an interface. Therefore, you can implement any class.
class MockSpaceship implements Spacecraft {
	// ...
}

// Read more about implicit interfaces.
// You can create an abstract class to be extended (or implemented) by
// a concrete class. Abstract classes can contain abstract methods
// (with empty bodies).
abstract class Describable {
	void describe();

	void describeWithEmphasis() {
		print("============");
		describe();
		print("============");
	}
}

// Any class extending Describable has the describeWithEmphasis()
// method, which calls the extender's implementation of describe().
// Read more about abstract classes and methods.


void main() {
	// You might use the Spacecraft class like this:
	var voyager = Spacecraft("Voyager I", DateTime(1977, 9, 5));
	voyager.describe();

	var voyager3 = Spacecraft.unlaunched("Voyager III");
	voyager3.describe();

	// Read more about classes in Dart, including initializer lists,
	// optional new and const, redirecting constructors, factory
	// constructors, getters, setters, and much more.
}
// IPFS-Console-Interact
// Sources (Reference):
// https://api.flutter.dev/flutter/dart-io/Platform-class.html
// https://api.dart.dev/stable/2.16.1/dart-io/Process/run.html
// https://api.dart.dev/stable/2.16.1/dart-io/File-class.html
// https://api.dart.dev/stable/2.16.1/dart-core/List/indexOf.html
// http://docs.ipfs.io.ipns.localhost:8080/reference/cli/#ipfs
// http://docs.ipfs.io.ipns.localhost:8080/how-to/command-line-quick-start/


// Import packages.
import "dart:io";


void main() async {
	// Print current OS (string). Could also use the following functions
	// to check for specific OS (boolean).
	// Platform.isAndroid
	// Platform.isIOS
	// Platform.isLinux
	// Platform.isMacOS
	// Platform.isWindows
	print("Host OS detected: " + Platform.operatingSystem);

	// Get the value of all environment variables. Isolate the PATH
	// variable.
	Map<String, String> enVars = Platform.environment;
	String pathKey = "PATH";
	if (enVars.keys.contains(pathKey)) {
		var pathVars = enVars[pathKey]; // String
	}

	// Within the PATH variables, search for the "ipfs" substring.
	bool containsIPFS = false;
	if (enVars["PATH"] != null) {
		// Splitting the mapped string by ";" (PATH variables separated
		// by ";").
		var pathVars = enVars["PATH"]?.split(";"); // List<String>

		// Iterate through each PATH variable string. If a string
		// contains the substring "ipfs" (ie go-ipfs), set the 
		// containsIPFS variable to true.
		pathVars?.forEach((path) {
			if (path.contains("ipfs")) {
				containsIPFS = true;
			}
		});
	}

	// Print whether there exists a PATH variable for IPFS.
	print("IPFS PATH variable found: " + containsIPFS.toString());

	// Check for internet connection.
	bool internetAvailable = await hasInternet();
	print("Internet connection status: " + (internetAvailable ? "Online" : "Offline"));

	// Pull data from IPFS and save it to file. Hash and output file
	// are from the IPFS Command-line quick start page.
	String ipfsTestJPGPath = "/ipfs/QmSgvgwxZGaBLqkGyWemEDqikCqU52XxsYLKtdy3vGZ8uq";
	String destinationPath = "./spaceship-launch.jpg";
	await pullFile(ipfsTestJPGPath, destinationPath);
	
	// Upload (new test) file to IPFS.
	String uploadPath = "./README.md";
	String newHash = await pushFile(uploadPath);
	if (newHash != "") {
		print("Uploaded file " + uploadPath + " with hash " + newHash);
	}
	else {
		print("Could not upload file " + uploadPath + " to IPFS");
	}

	// Publish (test) file to IPNS. 
}


// Check for internet connection.
Future<bool> hasInternet() async {
	bool internetAvailable = false;
	String ipfsHome = "ipfs.io";
	// String ipfsHome = "docs.ipfs.io";
	// String ipfsHome = "google.com";
	try {
		final result = await InternetAddress.lookup(ipfsHome);
		internetAvailable = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
	} on SocketException catch (_) {
		internetAvailable = false;
	}
	return internetAvailable;
}


// Download file from IPFS and save it to the specified path.
Future<void> pullFile(String hash, String path) async {
	// Note on "~": "~" is the same as
	// Platform.environment["USERPROFILE"] on windows and
	// Platform.environment["HOME"] on all other OS.
	// if (Platform.isWindows) {
	// 	String destinationPath = Platform.environment["USERPROFILE"] + "/spaceship-launch.jpg";
	// }
	// else {
	// 	String destinationPath = Platform.environment["HOME"] + "/spaceship-launch.jpg";
	// }
	// Read ipfs file and save:
	// "ipfs cat <hash> > output/file/path"
	var result = await Process.run("ipfs", ["cat", hash]);
	if (result.stderr.length > 0) {
		print(result.stderr);
	}
	else {
		// Write output from the ipfs cat command (string output) and
		// send it to the specified file path.
		File file = new File(path);
		if (!await file.exists()) {
			print("Creating file " + path);
			await file.create(recursive: true);
		}
		print("Writing data to file...");
		await file.writeAsString(result.stdout);
	}
}


// Upload a file to IPFS and return the hash string.
Future<String> pushFile(String path) async {
	// Validate path is valid.
	if (path == "" || path == null) {
		print("Error: File path is not defined.");
		return "";
	}
	else if (!await (File(path)).exists()) {
		print("Error: File path to upload to ipfs {" + path + "} does not exist.");
		return "";
	}

	// Upload a file to ipfs:
	// "ipfs add upload/path" [options]
	var result = await Process.run("ipfs", ["add", path]);
	if (result.stderr.contains("Error:")) {
		print("Error: File path to upload to ipfs {" + path + "}");
		return "";
	}
	print(result.stdout);
	print(result.stderr);
	if (result.stdout.contains("added")) {
		List<String> outputSplit = result.stdout.split(" ");
		String hash = outputSplit[outputSplit.indexOf("added") + 1];
		return hash;
	}
	return "";
}
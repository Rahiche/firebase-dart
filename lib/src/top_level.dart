import 'app.dart';
import 'auth.dart';
import 'database.dart';
import 'interop/firebase_interop.dart' as firebase;
import 'storage.dart';

export 'interop/firebase_interop.dart' show SDK_VERSION;

/// A (read-only) array of all the initialized Apps.
///
/// See: <https://firebase.google.com/docs/reference/js/firebase#.apps>.
List<App> get apps =>
    firebase.apps.map((jsApp) => new App.fromJsObject(jsApp)).toList();

const String _DEFAULT_APP_NAME = "[DEFAULT]";

/// Create (and initialize) a Firebase App.
///
/// See: <https://firebase.google.com/docs/reference/js/firebase#.initializeApp>.
App initializeApp(
    {String apiKey,
    String authDomain,
    String databaseURL,
    String storageBucket,
    String name}) {
  if (name == null) {
    name = _DEFAULT_APP_NAME;
  }

  return new App.fromJsObject(firebase.initializeApp(
      new firebase.FirebaseOptions(
          apiKey: apiKey,
          authDomain: authDomain,
          databaseURL: databaseURL,
          storageBucket: storageBucket),
      name));
}

App _app;

/// Retrieve an instance of a FirebaseApp.
///
/// With no arguments, this returns the default App. With a single
/// string argument, it returns the named App.
///
/// This function throws an exception if the app you are trying
/// to access does not exist.
///
/// See: <https://firebase.google.com/docs/reference/js/firebase.app>.
App app([String name]) {
  var jsObject = (name != null) ? firebase.app(name) : firebase.app();

  if (_app != null) {
    _app.jsObject = jsObject;
  } else {
    _app = new App.fromJsObject(jsObject);
  }
  return _app;
}

Auth _auth;

/// Gets the Auth object for the default App or a given App.
///
/// See: <https://firebase.google.com/docs/reference/js/firebase.auth>.
Auth auth([App app]) {
  var jsObject = (app != null) ? firebase.auth(app.jsObject) : firebase.auth();

  if (_auth != null) {
    _auth.jsObject = jsObject;
  } else {
    _auth = new Auth.fromJsObject(jsObject);
  }
  return _auth;
}

Database _database;

/// Access the Database service for the default App (or a given app).
///
/// Firebase [Database] is also a namespace that can be used to access
/// global constants and methods associated with the database service.
///
/// See: <https://firebase.google.com/docs/reference/js/firebase.database>.
Database database([App app]) {
  var jsObject =
      (app != null) ? firebase.database(app.jsObject) : firebase.database();

  if (_database != null) {
    _database.jsObject = jsObject;
  } else {
    _database = new Database.fromJsObject(jsObject);
  }
  return _database;
}

Storage _storage;

/// The namespace for all Firebase Storage functionality.
/// The returned service is initialized with a particular app which contains
/// the project's storage location, or uses the default app if none is provided.
///
/// See: <https://firebase.google.com/docs/reference/js/firebase.storage>.
Storage storage([App app]) {
  var jsObject =
      (app != null) ? firebase.storage(app.jsObject) : firebase.storage();

  if (_storage != null) {
    _storage.jsObject = jsObject;
  } else {
    _storage = new Storage.fromJsObject(jsObject);
  }
  return _storage;
}

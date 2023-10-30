# Mboacare Admin Panel

The Mboacare Admin Panel is a flutter web application developed with Flutter and Firebase. This Flutter web application will act as an intermediate between Mboacare administrators to be able to manage the all the request coming from the Mboacare mobile application. This admin panel will prevent direct access in to the database. It consist of 4 sub-modules which are Users Module, Hospital Module, Blog Module, and Notification module. For Hospital Module some sections involved is Approving hospitals.

## Installation And Setup

### Requirement

- Flutter and Dart
- firebase CLI (Command line interface)
- IDE (any of your choice) this api is being develope using VS code IDE

### Installation

- Flutter is an open-source UI (User Interface) framework developed by Google. It allows developers to create high-performance, cross-platform mobile, web, and desktop applications using a single codebase. Flutter uses the Dart programming language for building applications.
- Dart is a programming language also developed by Google. It is optimized for building user interfaces and is the primary language used for developing applications with Flutter.
    - Go to [Flutter main site](https://docs.flutter.dev/get-started/install), select your OS and download the Zip file for the SDK.

    - Go to [Dart main site](https://dart.dev/get-dartl), select your OS and download the Zip file for the SDK.

    - This Youtube link also helped me in setting [Installing Flutter and dart](https://www.youtube.com/watch?v=nkOliNYv59Q).

- Firebase CLI (Command Line Interface) is a command-line tool provided by Google for communicating with Firebase services and managing Firebase projects from the command line. It enables developers to perform various tasks, such as deploying applications, managing databases, configuring hosting, and accessing other Firebase services, all through a command-line interface.

For Firebase CLI checkout the official documentation [firebase cli](https://firebase.google.com/docs/cli)

 ```bash
 using npm
 npm install -g firebase-tools

 login into firebase using cli
 firebase login

 Initialize firebase project
 firebase init

 deploying changes
 firebase deploy
 ```

### Project setup

#### Clone the repository

```bash
git clone <repo link>
```

#### Installing dependencies

```bash
cd mboacare_admin
flutter pub get
```

#### Start the project local

```bash
flutter run web 
```

#### To build for deployment

```bash
flutter build web
```

## Note

- Project uses  sdk: '>=3.1.0 <4.0.0'

## License

The Mboacare-Admin Panel is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).


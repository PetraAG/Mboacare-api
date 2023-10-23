# Mboacare-api

Mboacare API is a RESTful API developed using Node.js and Firebase. This API serves as a central component in managing various activities within the main Mboacare application, while interacting with the database. Some of features includes user authentication, hospital management, and much more.

## Installation And Setup

### Requirement

- Node js and npm
- firebase CLI (Command line interface)
- Postman for testing the endpoints
- IDE (any of your choice) this api is being develope using VS code IDE

### Installation

- Node.js is a server-side JavaScript runtime environment that enables developers to build scalable and efficient web applications. It make use of JavaScript as a full-stack language. It has a rich ecosystem of libraries and modules. Some libraries we have made use of in this api include:
  - nodemailer: A node js package use in sending out mails to authenticated users.
  - dotenv: which is use to store environmental variables
  - express: which is a package use to route our endpoints
  - nodemon: which is a package use to ensure hot reload features of our server

```bash

 - we use this npm command to install packages

 npm install <package name>
```

For Node JS and npm checkout this medium content [Node JS and npm installation for windows](https://medium.com/@deshayk/how-to-node-js-and-npm-instillation-c438cbe4d2b4) and other operating system checkout my medium content [other OS](https://nyonggodwill11.medium.com/installing-node-js-and-npm-269ba670a571)

- Postman is a popular collaboration platform and API development tool used by developers to simplify the process of testing, documenting, and sharing APIs. It provides a user-friendly interface that allows developers to easily make HTTP requests, inspect responses, and analyze data exchanged between their applications and APIs. Some most popular HTTP request done on postman includes:
  - GET: Retrieve all data in the database to the user
  - POST: Upload or add data to the database from the user
  - PUT: Updates data in the database from the user.
  - DELETE: Remove data from the database.
  
  - For Postman sign up here [Get Started](https://www.postman.com/). You can also download the installable file for postman.

- Firebase CLI (Command Line Interface) is a command-line tool provided by Google for communicating with Firebase services and managing Firebase projects from the command line. It enables developers to perform various tasks, such as deploying applications, managing databases, configuring hosting, and accessing other Firebase services, all through a command-line interface.

For Firebase CLI checkout the official documentation [firebase cli](https://firebase.google.com/docs/cli)

 ```bash
 using npm
 npm install -g firebase-tools
 ```

### Project setup

#### Clone the repository

```bash
git clone <repo link>
```

#### Installing dependencies

```bash
cd Mboacare-api
npm install
```

#### Start the local development server

```bash
npm start
```

#### Open your local browser and verify the Mboacare-api is working by accessing

`http://localhost:8080/mboacare-api/`

## Using Postman to test the various endpoints

To test an endpoint such us registering new users in the system, we carry out the various steps:

- launch the post web url and sign in or sign up if you don't have an account
- You can also make use of the installable version but it requires you are authenticated.
- Head on to your workspace there you are able to carry out request such as post, put, delete and get.
- Every endpoint consist of a baseUrl and the endpoints.

### Postman testing

- Here our baseUrl is `http://localhost:3000` and enpoint is `/mboacare-api/register`.
- Since we are adding data to the database the method is `POST`.
- The body we are sending is `email` and `password`.
- We get a response base on the state, it can be success or failure. The user is notify on the status of action taking.
- Below is the image of postman with it results both in postman and the database.

- Postman test and result:

  ![](/src/test/status.jpg)

- Database result:

  ![](/src/test/database.jpg)

## Note

- Project uses but node version 16

## Link to API documentation

- [API Doc](https://documenter.getpostman.com/view/23068653/2s9YRB4D8Q)

## License

The Mboacare-api is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

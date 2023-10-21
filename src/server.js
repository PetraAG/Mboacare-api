const express = require("express");
const cors = require("cors");
const app = express();
const functions = require("firebase-functions");
const { UserController } = require("./controller/users/userController.js");

app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

const PORT = process.env.PORT || 8080;
//const PORT = 3000;

app.get("/", (req, res) => {
  res.send("Welcome to mboacare");
});

//Auth endpoint
app.post("/mboacare-api/register", UserController.register);
app.post("/mboacare-api/sign-in", UserController.login);
app.put("/mboacare-api/update-profile", UserController.update);

app.listen(PORT, () => {
  console.log(`Server is running on PORT ${PORT}.`);
});

//exports.api = functions.https.onRequest(app);

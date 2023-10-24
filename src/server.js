const express = require("express");
const cors = require("cors");
const app = express();
const functions = require("firebase-functions");
const { UserController } = require("./controller/users/userController.js");
const {
  hospitalController,
} = require("./controller/hospitals/hospitalController.js");

app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

const PORT = process.env.PORT || 8080;
//const PORT = 2000;

app.get("/", (req, res) => {
  res.send("Welcome to mboacare");
});

//Auth routes
app.post("/mboacare-api/register", UserController.register);
app.post("/mboacare-api/sign-in", UserController.login);
app.put("/mboacare-api/update-profile", UserController.update);
app.post("/mboacare-api/reset-password", UserController.reset_password);

//hospital routes
app.post("/mboacare-api/add-hospital", hospitalController.add_hospital);
app.post("/mboacare-api/update-hospital", hospitalController.update_hospital);
app.post("/mboacare-api/approve-hospital", hospitalController.approve_hospital);
app.get("/mboacare-api/all-hospital", hospitalController.all_hospitals);
app.get("/mboacare-api/single-hospital/:id", hospitalController.singleHospital);
app.delete(
  "/mboacare-api/delete-hospital/:id",
  hospitalController.delete_hospital
);

app.listen(PORT, () => {
  console.log(`Server is running on PORT ${PORT}.`);
});

exports.api = functions.https.onRequest(app);

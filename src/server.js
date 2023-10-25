const express = require("express");
const cors = require("cors");
const app = express();
const functions = require("firebase-functions");
const { blogController } = require("./controller/blog/blogController.js");
const authRouter = require("./routes/authRouts.js");
const hospitalRouter = require("./routes/hospitalRoutes.js");
const blogRoute = require("./routes/blogRoutes.js");

app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

//const PORT = process.env.PORT || 8080;
const PORT = 4000;

app.get("/", (req, res) => {
  res.send("Welcome to mboacare");
});

//App routes
app.use("/auth", authRouter);
app.use("/hospital", hospitalRouter);
app.use("/blog", blogRoute);

app.listen(PORT, () => {
  console.log(`Server is running on PORT ${PORT}.`);
});

exports.api = functions.https.onRequest(app);

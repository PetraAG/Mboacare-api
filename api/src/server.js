const express = require("express");
const cors = require("cors");
const app = express();
const dotenv = require("dotenv").config();
const functions = require("firebase-functions");
const { blogController } = require("./controller/blog/blogController.js");
const authRouter = require("./routes/authRouts.js");
const hospitalRouter = require("./routes/hospitalRoutes.js");
const blogRoute = require("./routes/blogRoutes.js");
const notificationRoutes = require("./routes/notificationRouts.js");

app.use(express.json());
app.use(cors.apply({ origin: true }));
app.use(express.urlencoded({ extended: true }));

//const PORT = process.env.PORT || 3000;
const PORT = 4000;

app.get("/", (req, res) => {
  res.send("Welcome to mboacare");
});

//App routes
app.use("/auth", authRouter);
app.use("/hospital", hospitalRouter);
app.use("/blog", blogRoute);
app.use("/notification", notificationRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on PORT ${PORT}.`);
});
exports.api = functions.https.onRequest(app);

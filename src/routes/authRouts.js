const express = require("express");

const router = express.Router();
const { UserController } = require("../controller/users/userController.js");

//Auth endpoints
router.post("/register", UserController.register);
router.post("/sign-in", UserController.login);
router.put("/update-profile", UserController.update);
router.post("/reset-password", UserController.reset_password);

module.exports = router;

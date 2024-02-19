const express = require("express");

const router = express.Router();
const { UserController } = require("../controller/users/userController.js");

//Auth endpoints
router.post("/register", UserController.register);
router.post("/sign-in", UserController.login);
router.put("/update-profile", UserController.update_profile);
router.put("/change-password", UserController.change_password);
router.post("/reset-password", UserController.reset_password);
router.post("/send-link", UserController.sendlink);
router.post("/user", UserController.getUser);

module.exports = router;

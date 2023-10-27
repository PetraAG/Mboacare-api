const express = require("express");

const {
  notificationController,
} = require("../controller/notifications/notificationController.js");
const router = express.Router();

//notification routes
router.post("/add-notification", notificationController.add_notification);
router.put("/update-notification/:id", notificationController.update_notification);
router.get("/all-notifications", notificationController.all_notifications);
router.delete(
  "/delete-notification/:id",
  notificationController.delete_notification
);
router.get(
  "/single-notifications/:id",
  notificationController.notificationById
);

module.exports = router;

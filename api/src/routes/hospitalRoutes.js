const express = require("express");
const {
  hospitalController,
} = require("../controller/hospitals/hospitalController.js");
const router = express.Router();

router.post("/add-hospital", hospitalController.add_hospital);
router.put("/update-hospital", hospitalController.update_hospital);
router.post("/approve-hospital", hospitalController.approve_hospital);
router.get("/all-hospital", hospitalController.all_hospitals);
router.get("/hospitals", hospitalController.hospitals);
router.get("/my-hospitals", hospitalController.list_hospital);
router.get("/search", hospitalController.search_hospital);
router.get("/single-hospital/:id", hospitalController.singleHospital);
router.delete("/delete-hospital/:id", hospitalController.delete_hospital);

module.exports = router;

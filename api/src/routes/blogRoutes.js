const express = require("express");
const router = express.Router();
const { blogController } = require("../controller/blog/blogController.js");

router.post("/add-blog", blogController.add_blog);
router.get("/all-blogs", blogController.all_blogs);
router.get("/my-blogs", blogController.list_blog);
router.get("/single-blog/:id", blogController.blogById);
router.delete("/delete-blog/:id", blogController.delete_blog);
router.post("/update-blog", blogController.update_blog);
router.get("/search", blogController.search_blog);
router.get("/filter", blogController.filter_blog);


module.exports = router;

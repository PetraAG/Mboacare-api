const express = require("express");
const { Storage } = require("@google-cloud/storage");
const UUID = require("uuid-v4");
const formidable = require("formidable-serverless");
//const { Utils } = require("../../src/utils/firebase_init.js");
const { Utils } = require("../../utils/firebase_init");

const admin = Utils.init_files;

const db = admin.firestore();

const blogRef = db.collection("blogs");
const storage = new Storage({
  keyFilename: "serviceAccountKey.json",
});

exports.blogController = {
  add_blog: async (req, res) => {
    const form = new formidable.IncomingForm({ multiples: true });
    try {
      form.parse(req, async (err, fields, files) => {
        let uuid = UUID();
        var downLoadPath =
          "https://firebasestorage.googleapis.com/v0/b/mboacare-api-v1.appspot.com/o/";

        const blogImage = files.blogImage;

        // url of the uploaded image
        let imageUrl;

        const docID = blogRef.doc().id;

        if (err) {
          return res.status(400).json({
            message: "There was an error parsing the files",
            data: {},
            error: err,
          });
        }
        const bucket = storage.bucket("gs://mboacare-api-v1.appspot.com");

        if (blogImage.size == 0) {
          // do nothing
        } else {
          const imageResponse = await bucket.upload(blogImage.path, {
            destination: `blogs/${blogImage.name}`,
            resumable: true,
            metadata: {
              metadata: {
                firebaseStorageDownloadTokens: uuid,
              },
            },
          });
          // profile image url
          imageUrl =
            downLoadPath +
            encodeURIComponent(imageResponse[0].name) +
            "?alt=media&token=" +
            uuid;
        }
        // object to send to database
        const blogModel = {
          id: docID,
          blogTitle: fields.blogTitle,
          blogAuthor: fields.blogAuthor,
          blogSubtitle: fields.blogSubtitle,
          blogContent: fields.blogContent,
          blogWebLink: fields.blogWebLink,
          blogCat: [fields.blogCat],
          blogPubDate: fields.blogPubDate,
          blogImage: blogImage.size == 0 ? "" : imageUrl,
        };
        if (!blogModel.blogTitle) {
          res.status(400).send({ message: "Blog Title is required!" });
          return;
        }
        if (!blogModel.blogContent) {
          res.status(400).send({ message: "Blog Content is required!" });
          return;
        }
        if (!blogModel.blogAuthor) {
          res.status(400).send({ message: "Blog Author is required!" });
          return;
        }

        if (!blogModel.blogCat) {
          res.status(400).send({ message: "Blog Category is required!" });
          return;
        }

        await blogRef
          .doc(blogModel.blogTitle)
          .create(blogModel, { merge: true })
          .then((value) => {
            // return response to users
            res.status(200).send({
              message: "Blog created successfully!",
              data: blogModel,
              error: {},
            });
          });
      });
    } catch (err) {
      res.send({
        message: "Something went wrong",
        data: {},
        error: err.message,
      });
    }
  },

  all_blogs: async (req, res, next) => {
    await blogRef.get().then((value) => {
      const data = value.docs.map((doc) => doc.data());
      res.status(200).send({
        message: "Fetched all blog",
        data: data,
      });
    });
  },

  blogById: async (req, res) => {
    try {
      const blogData = db.collection("blogs").doc(req.params.id);
      const response = await blogData.get();
      res.send({ data: response.data() });
    } catch (error) {
      res.send(error);
    }
  },

  update_blog: async (req, res) => {
    const form = new formidable.IncomingForm({ multiples: true });
    try {
      form.parse(req, async (err, fields, files) => {
        let uuid = UUID();
        var downLoadPath =
          "https://firebasestorage.googleapis.com/v0/b/mboacare-api-v1.appspot.com/o/";

        const blogImage = files.blogImage;

        // url of the uploaded image
        let imageUrl;

        const docID = blogRef.doc().id;

        if (err) {
          return res.status(400).json({
            message: "There was an error parsing the files",
            data: {},
            error: err,
          });
        }
        const bucket = storage.bucket("gs://mboacare-api-v1.appspot.com");

        if (blogImage.size == 0) {
          // do nothing
        } else {
          const imageResponse = await bucket.upload(blogImage.path, {
            destination: `blogs/${blogImage.name}`,
            resumable: true,
            metadata: {
              metadata: {
                firebaseStorageDownloadTokens: uuid,
              },
            },
          });
          // profile image url
          imageUrl =
            downLoadPath +
            encodeURIComponent(imageResponse[0].name) +
            "?alt=media&token=" +
            uuid;
        }
        // object to send to database
        const blogModel = {
          id: docID,
          blogTitle: fields.blogTitle,
          blogAuthor: fields.blogAuthor,
          blogSubtitle: fields.blogSubtitle,
          blogContent: fields.blogContent,
          blogWebLink: fields.blogWebLink,
          blogCat: [fields.blogCat],
          blogPubDate: fields.blogPubDate,
          blogImage: blogImage.size == 0 ? "" : imageUrl,
        };

        if (!blogModel.blogTitle) {
          res.status(400).send({ message: "Blog Title is required!" });
          return;
        }
        await blogRef
          .doc(docID)
          .update(blogModel, { merge: true })
          .then((value) => {
            // return response to users
            res.status(200).send({
              message: "Blog Updated successfully!",
              data: blogModel,
              error: {},
            });
          });
      });
    } catch (err) {
      res.send({
        message: "Something went wrong",
        data: {},
        error: err.message,
      });
    }
  },

  delete_blog: async (req, res) => {
    try {
      const response = await db.collection("blogs").doc(req.params.id).delete();

      res.send({ message: "Blog deleted successful", data: response });
    } catch (error) {
      res.send(error.message);
    }
  },
};

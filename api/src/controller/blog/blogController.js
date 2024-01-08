const express = require("express");
const { Storage } = require("@google-cloud/storage");
const UUID = require("uuid-v4");
const formidable = require("formidable-serverless");
const { Utils } = require("../../utils/firebase_init");
const nodemailer = require("nodemailer");

const admin = Utils.init_files;

const db = admin.firestore();

const blogRef = db.collection("blogs");
const storage = new Storage({
  keyFilename: "serviceAccountKey.json",
});

exports.blogController = {
  add_blog: async (req, res) => {
    const now = new Date();
    const currentDateTime = now.toLocaleString();
    const form = new formidable.IncomingForm({ multiples: true });
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        //port: 587,
        auth: {
          user: process.env.email,
          pass: process.env.pass,
        },
      });
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
          userEmail: fields.userEmail,
          blogAuthor: fields.blogAuthor,
          blogWebLink: fields.blogWebLink,
          blogCat: [fields.blogCat],
          blogPubDate: currentDateTime,
          isApprove: false,
          blogImage: blogImage.size == 0 ? "" : imageUrl,
        };
        if (!blogModel.blogTitle) {
          res.status(400).send({ message: "Blog Title is required!" });
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

        if (!blogModel.userEmail) {
          res.status(400).send({ message: "User Email is required!" });
          return;
        }

        await blogRef
          .doc(blogModel.blogTitle)
          .create(blogModel, { merge: true })
          .then((value) => {
            // return response to users
            res.status(200).send({
              message:
                "Blog submitted successfully check email for blog status!!",
              data: blogModel,
              error: {},
            });
          });
        const mailOptions = {
          from: process.env.email,
          to: blogModel.userEmail,
          subject: "Blog Submission Successful",
          html: `
            <p>Dear ${blogModel.blogAuthor}.</p>
      
              <p>Thank you for submitting your blog details. We have received your information and it is currently under review.</p>
              <p>Our team will carefully evaluate your submission and get back to you as soon as possible.</p>
      
              <p>Please note that the review process may take some time, depending on the information provided in your submission.</p>
              <p> We appreciate your patience and understanding.</p>
  
              <p>If you have any urgent inquiries or need immediate assistance, please don't hesitate
              to contact our support team at <support email></p>
              
      
              <p>Thank you for choosing Mboacare.</p>
      
             <p> Best regards,</p>
             <p> Mboacare</p>`,
        };
        await transporter.sendMail(mailOptions);
      });
    } catch (err) {
      res.json({
        message: err.message,
        data: {},
      });
    }
  },

  // all_blogs: async (req, res, next) => {
  //   await blogRef.get().then((value) => {
  //     const data = value.docs.map((doc) => doc.data());
  //     res.status(200).send({
  //       message: "Fetched all blog",
  //       data: data,
  //     });
  //   });
  // },

  blogById: async (req, res) => {
    try {
      const blogData = db.collection("blogs").doc(req.params.id);
      const response = await blogData.get();
      res.send({ data: response.data() });
    } catch (error) {
      res.send(error.message);
    }
  },

  update_blog: async (req, res) => {
    const now = new Date();
    const currentDateTime = now.toLocaleString();
    const form = new formidable.IncomingForm({ multiples: true });
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        //port: 587,
        auth: {
          user: process.env.email,
          pass: process.env.pass,
        },
      });
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
          userEmail: fields.userEmail,
          blogAuthor: fields.blogAuthor,
          blogWebLink: fields.blogWebLink,
          blogCat: [fields.blogCat],
          blogPubDate: currentDateTime,
          isApprove: false,
          blogImage: blogImage.size == 0 ? "" : imageUrl,
        };
        if (!blogModel.userEmail) {
          res.status(400).send({ message: "User Email is required!" });
          return;
        }
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
              message: "Blog Updated successfully check email for blog status!",
              data: blogModel,
              error: {},
            });
          });
        const mailOptions = {
          from: process.env.email,
          to: blogModel.userEmail,
          subject: "Blog Update Submission Successful",
          html: `
            <p>Dear ${blogModel.blogAuthor}.</p>
      
              <p>Thank you for updating your blog details. We have received your information and it is currently under review.</p>
              <p>Our team will carefully evaluate your submission and get back to you as soon as possible.</p>
      
              <p>Please note that the review process may take some time, depending on the information provided in your submission.</p>
              <p> We appreciate your patience and understanding.</p>
  
              <p>If you have any urgent inquiries or need immediate assistance, please don't hesitate
              to contact our support team at <support email>.</p>
              
      
              <p>Thank you for choosing Mboacare.</p>
      
             <p>Best regards,</p>
             <p>Mboacare</p>`,
        };
        await transporter.sendMail(mailOptions);
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

  list_blog: async (req, res) => {
    try {
      const query = req.query.q;

      const queryRef = await admin
        .firestore()
        .collection("blogs")
        .where("userEmail", "==", query);
      // Get the search results
      const results = await queryRef.get();
      // Send the search results to the response
      response = results.docs.map((doc) => doc.data());
      res.status(200).send({ data: response });
    } catch (error) {
      res.status(401).send({ message: error.message });
    }
  },
  search_blog: async (req, res) => {
    // Get the search query from the request

    // try {
    //   const query = req.query.q;

    //   // Create a Firestore query
    //   const queryRef = await admin
    //     .firestore()
    //     .collection("blogs")
    //     .where("blogTitle", "==", query);
    //   // Get the search results
    //   const results = await queryRef.get();
    //   // Send the search results to the response
    //   res.status(200).send(results.docs.map((doc) => doc.data()));
    // } catch (error) {
    //   res.status(401).send({ message: error.message });
    // }
    try {
      const query1 = req.query.q;

      const query = db.collection("blogs"); // Replace with your collection name

      // Build the query using multiple where conditions
      query.where("blogTitle", "==", query1);
      query.where("blogAuthor", "==", query1);
      // Add more where conditions for additional fields

      const snapshot = await query.get();
      const results = snapshot.docs.map((doc) => doc.data());

      res.json({data: results});
    } catch (err) {
      // console.error(err);
      res.status(500).send("Error fetching data");
    }
  },
  filter_blog: async (req, res) => {
    try {
      // Assuming you have a ' blogPubDate' timestamp field to determine newest items
      const query = db.collection("blogs").orderBy("blogPubDate", "asc"); // Sort by  blogPubDate in descending order

      const snapshot = await query.get();
      const newestItems = snapshot.docs.map((doc) => doc.data());

      res.json({ data: newestItems });
    } catch (err) {
      console.error(err);
      res.status(500).send({ message: "Error fetching newest items" });
    }
  },

  all_blogs: async (req, res) => {
    try {
    

      const queryRef = await admin
        .firestore()
        .collection("blogs")
        .where("isApprove", "==", true);
     
      const results = await queryRef.get();
      
      response = results.docs.map((doc) => doc.data());
      res.status(200).send({ data: response });
    } catch (error) {
      res.status(401).send({ message: error.message });
    }
  },
};

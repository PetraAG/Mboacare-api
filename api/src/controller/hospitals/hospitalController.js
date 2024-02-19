const express = require("express");
const nodemailer = require("nodemailer");
const { Storage } = require("@google-cloud/storage");
const UUID = require("uuid-v4");
const formidable = require("formidable-serverless");
const { Utils } = require("../../utils/firebase_init.js");

const admin = Utils.init_files;
const db = admin.firestore();
const hospitalRef = db.collection("hospitals");
const storage = new Storage({
  keyFilename: "serviceAccountKey.json",
});

exports.hospitalController = {
  add_hospital: async (req, res) => {
    const form = new formidable.IncomingForm({ multiples: true });
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        //port: 587,
        auth: {
          user: process.env.EMAIL,
          pass: process.env.PASS,
        },
      });

      form.parse(req, async (err, fields, files) => {
        let uuid = UUID();
        var downLoadPath =
          "https://firebasestorage.googleapis.com/v0/b/mboacare-api-v1.appspot.com/o/";

        const hospitalImage = files.hospitalImage;

        // url of the uploaded image
        let imageUrl;

        const docID = hospitalRef.doc().id;

        if (err) {
          return res.status(400).json({
            message: "There was an error parsing the files",
            data: {},
            error: err,
          });
        }
        const bucket = storage.bucket("gs://mboacare-api-v1.appspot.com");

        if (hospitalImage.size == 0) {
          return res.status(400).json({
            message: "Image is required",
            data: {},
            error: err,
          });
          // do nothing
        } else {
          const imageResponse = await bucket.upload(hospitalImage.path, {
            destination: `hospitals/${hospitalImage.name}`,
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

        const hospitalModel = {
          id: docID,
          userEmail: fields.userEmail,
          name: fields.name,
          phoneNumber: fields.phoneNumber,
          email: fields.email,
          website: fields.website,
          placeAddress: fields.placeAddress,
          latitude: fields.latitude,
          longitude: fields.longitude,
          serviceType: [fields.serviceType],
          facilitiesType: [fields.facilitiesType],
          hospitalType: fields.hospitalType,
          hospitalOwner: fields.hospitalOwner,
          hospitalSize: fields.hospitalSize,
          isApprove: false,
          hospitalImage: hospitalImage.size == 0 ? "" : imageUrl,
        };
        if (!hospitalModel.userEmail) {
          res.status(400).send({ message: "Creator email  is required!" });
          return;
        }
        if (!hospitalModel.website) {
          res.status(400).send({ message: "Website is required!" });
          return;
        }
        if (!hospitalModel.email) {
          res.status(400).send({ message: "email is required!" });
          return;
        }
        if (!hospitalModel.name) {
          res.status(400).send({ message: "Name is required!" });
          return;
        }
        await hospitalRef
          .doc(hospitalModel.id)
          .create(hospitalModel, { merge: true })
          .then((value) => {
            // return response to users
            res.status(200).send({
              message: "hospital created successfully!",
              data: hospitalModel,
              error: {},
            });
          });
        const mailOptions = {
          from: process.env.EMAIL,
          to: hospitalModel.userEmail,
          subject: "Hospital Details Submission Successful",
          html: `
          <p>Dear ${hospitalModel.name}.</p>
    
            <p>Thank you for submitting your application . We have received your information and it is currently under review.</p>
            <p>Our team will carefully evaluate your submission and get back to you as soon as possible.</p>
    
            <p>Please note that the review process may take some time, depending on the information provided in your submission.</p>
           <p> We appreciate your patience and understanding.</p>

            <p>Note that after a successful review you will be able to manage your facilities
            like update, upload and delete health facility.</p>
    
            <p>If you have any urgent inquiries or need immediate assistance, please don't hesitate
            to contact our support team at <a>mboacare237@gmail.com</a></p>
            
    
            <p>Thank you for choosing Mboacare.</p>
    
           <p> Best regards,</p>
           <p> Mboacare</p>`,
        };
        await transporter.sendMail(mailOptions);
      });
    } catch (error) {
      res.send({ status: error.code, message: error.message });
    }
  },

  // all_hospitals: async (req, res) => {
  //   try {
  //     const hospitalData = db.collection("hospitals");
  //     const response = await hospitalData.get();

  //     let responseData = [];
  //     response.forEach((doc) => {
  //       responseData.push(doc.data());
  //     });
  //     res.send({
  //       data: responseData,
  //     });
  //   } catch (error) {
  //     res.send(error);
  //   }
  // },
  all_hospitals: async (req, res) => {
    try {
      const queryRef = await admin
        .firestore()
        .collection("hospitals")
        .where("isApprove", "==", true);

      const results = await queryRef.get();

      response = results.docs.map((doc) => doc.data());
      res.status(200).send({ data: response });
    } catch (error) {
      res.status(401).send({ message: error.message });
    }
  },

  hospitals: async (req, res) => {
    try {
      const hospitalData = db.collection("hospitals");
      const response = await hospitalData.get();

      let responseData = [];
      response.forEach((doc) => {
        responseData.push(doc.data());
      });
      res.send({
        data: responseData,
      });
    } catch (error) {
      res.send(error);
    }
  },

  singleHospital: async (req, res) => {
    try {
      const hospitalData = db.collection("hospitals").doc(req.params.id);
      const response = await hospitalData.get();
      res.send({ data: response.data() });
    } catch (error) {
      res.send(error);
    }
  },

  update_hospital: async (req, res) => {
    const form = new formidable.IncomingForm({ multiples: true });
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        //port: 587,
        auth: {
          user: process.env.EMAIL,
          pass: process.env.PASS,
        },
      });

      form.parse(req, async (err, fields, files) => {
        let uuid = UUID();
        var downLoadPath =
          "https://firebasestorage.googleapis.com/v0/b/mboacare-api-v1.appspot.com/o/";

        const hospitalImage = files.hospitalImage;

        // url of the uploaded image
        let imageUrl;

        const docID = hospitalRef.doc().id;

        if (err) {
          return res.status(400).json({
            message: "There was an error parsing the files",
            data: {},
            error: err,
          });
        }
        const bucket = storage.bucket("gs://mboacare-api-v1.appspot.com");

        if (hospitalImage.size == 0) {
          return res.status(400).json({
            message: "Image is required",
            data: {},
            error: err,
          });
          // do nothing
        } else {
          const imageResponse = await bucket.upload(hospitalImage.path, {
            destination: `hospitals/${hospitalImage.name}`,
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
        const hospitalModel = {
          id: docID,
          userEmail: fields.userEmail,
          name: fields.name,
          phoneNumber: fields.phoneNumber,
          email: fields.email,
          website: fields.website,
          placeAddress: fields.placeAddress,
          latitude: fields.latitude,
          longitude: fields.longitude,
          serviceType: [fields.serviceType],
          facilitiesType: [fields.facilitiesType],
          hospitalType: fields.hospitalType,
          hospitalOwner: fields.hospitalOwner,
          hospitalSize: fields.hospitalSize,
          isApprove: false,
          hospitalImage: hospitalImage.size == 0 ? "" : imageUrl,
        };
        if (!hospitalModel.userEmail) {
          res.status(400).send({ message: "Creator email is required!" });
          return;
        }
        if (!hospitalModel.website) {
          res.status(400).send({ message: "Website is required!" });
          return;
        }
        if (!hospitalModel.email) {
          res.status(400).send({ message: "email is required!" });
          return;
        }
        if (!hospitalModel.name) {
          res.status(400).send({ message: "Name is required!" });
          return;
        }
        await hospitalRef
          .doc(hospitalModel.id)
          .update(hospitalModel, { merge: true })
          .then((value) => {
            // return response to users
            res.status(200).send({
              message: "hospital updated successfully!",
              data: hospitalModel,
              error: {},
            });
          });
        const mailOptions = {
          from: process.env.EMAIL,
          to: hospitalModel.userEmail,
          subject: "Hospital Details updated Successful!",
          html: `
          <p>Dear ${hospitalModel.name}.</p>
      
          <p>Thank you for submitting your application . We have received your information and it is currently under review.</p>
          <p>Our team will carefully evaluate your submission and get back to you as soon as possible.</p>
      
          <p>Please note that the review process may take some time, depending on the information provided in your submission.</p>
          <p>We appreciate your patience and understanding.</p>
  
          <p>Note that after a successful review you will be able to manage your facilities
           like update, upload and delete health facility.</p>
      
          <p>If you have any urgent inquiries or need immediate assistance, please don't hesitate
          to contact our support team at <a>mboacare237@gmail.com</a>.</p>
              
      
          <p>Thank you for choosing Mboacare.</p>
      
          <p>Best regards,</p>
          <p>Mboacare</p>`,
        };
        await transporter.sendMail(mailOptions);
      });
    } catch (error) {
      res.send({ status: error.code, message: error.message });
    }
  },

  approve_hospital: async (req, res) => {
    try {
      const { id, status } = req.body;

      const hospital = await db.collection("hospitals").doc(id).update({
        isApprove: status,
        id: id,
      });
      res.status(200).send({ data: hospital, message: "Hospital Approved!!" });
    } catch (error) {
      res.send(error.message);
    }
  },

  delete_hospital: async (req, res) => {
    try {
      const response = await db
        .collection("hospitals")
        .doc(req.params.id)
        .delete();
      res.send({
        message: "Hospital Deleted Successful!",
        data: response,
      });
    } catch (error) {
      res.send(error.message);
    }
  },
  list_hospital: async (req, res) => {
    try {
      const query = req.query.q;

      const queryRef = await admin
        .firestore()
        .collection("hospitals")
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

  search_hospital: async (req, res) => {
    // try {
    //   const query = req.query.q;

    //   const queryRef = await admin
    //     .firestore()
    //     .collection("hospitals")
    //     .where("name", "==", query);
    //   // Get the search results
    //   const results = await queryRef.get();
    //   // Send the search results to the response
    //   response = results.docs.map((doc) => doc.data());
    //   res.status(200).send({ data: response });
    // } catch (error) {
    //   res.status(401).send({ message: error.message });
    // }
    try {
      const { query, isApprove } = req.query.q;

      // Create a Firestore query
      const queryRef = await admin
        .firestore()
        .collection("hospitals")
        .where("isApprove", "==", true, "name", "==", query);

      // Get the search results
      const results = await queryRef.get();
      const response = results.docs.map((doc) => doc.data());
      // Send the search results to the response
      res.status(200).send({ data: response });
    } catch (error) {
      res.status(401).send({ message: error.message });
    }
  },
};

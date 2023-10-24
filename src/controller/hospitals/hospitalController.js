const express = require("express");
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
          idToken: fields.idToken,
          name: fields.name,
          phoneNumber: fields.phoneNumber,
          email: fields.email,
          website: fields.website,
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
        if (!hospitalModel.idToken) {
          res.status(400).send({ message: "idToken is required!" });
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
          .doc(hospitalModel.website)
          .create(hospitalModel, { merge: true })
          .then((value) => {
            // return response to users
            res.status(200).send({
              message: "hospital created successfully!",
              data: hospitalModel,
              error: {},
            });
          });
      });
    } catch (error) {
      res.send({ status: error.code, message: error.message });
    }
  },

  all_hospitals: async (req, res) => {
    try {
      const hospitalData = db.collection("hospitals");
      const response = await hospitalData.get();

      let responseData = [];
      response.forEach((doc) => {
        responseData.push(doc.data());
      });
      res.send(responseData);
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
          idToken: fields.idToken,
          name: fields.name,
          phoneNumber: fields.phoneNumber,
          email: fields.email,
          website: fields.website,
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
        if (!hospitalModel.idToken) {
          res.status(400).send({ message: "idToken is required!" });
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
          .doc(hospitalModel.website)
          .update(hospitalModel, { merge: true })
          .then((value) => {
            // return response to users
            res.status(200).send({
              message: "hospital updated successfully!",
              data: hospitalModel,
              error: {},
            });
          });
      });
    } catch (error) {
      res.send({ status: error.code, message: error.message });
    }
  },

  approve_hospital: async (req, res) => {
    try {
      const website = req.body.website;
      const status = req.body.status;
      const hospital = await db.collection("hospitals").doc(website).update({
        isApprove: status,
      });
      res.send({ data: hospital, message: "Hospital Approved!!" });
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
};

const express = require("express");
const { Utils } = require("../../utils/firebase_init.js");

const admin = Utils.init_files;

const db = admin.firestore();
const notificationRef = db.collection("notifications");
exports.notificationController = {
  add_notification: async (req, res) => {
    const now = new Date();
    const currentDateTime = now.toLocaleString();
    try {
      const docID = notificationRef.doc().id;
      const { title, content } = req.body;
      const notification = await notificationRef.doc(docID).create({
        id: docID,
        title: title,
        content: content,
        pubDate: currentDateTime,
      });
      if (!title) {
        res.status(401).send({
          message: "Title is required!",
        });
        return;
      }
      if (!content) {
        res.status(401).send({
          message: "Notification Body is required!",
        });
        return;
      }
      res.status(201).send({
        message: "Added new notification successful!",
        data: notification,
      });
    } catch (error) {
      res.status(401).send({
        message: error.message,
      });
    }
  },

  all_notifications: async (req, res) => {
    try {
      await notificationRef.get().then((value) => {
        const data = value.docs.map((doc) => doc.data());
        res.status(200).send({
          status: "ok!",
          data: data,
        });
      });
    } catch (error) {
      res.send(error.message);
    }
  },

  notificationById: async (req, res) => {
    try {
      const notificationData = db
        .collection("notifications")
        .doc(req.params.id);
      const response = await notificationData.get();
      res.send({ data: response.data() });
    } catch (error) {
      res.send(error.message);
    }
  },

  delete_notification: async (req, res) => {
    try {
      const response = await db
        .collection("notifications")
        .doc(req.params.id)
        .delete();

      res.send({ message: "Notification deleted successful", data: response });
    } catch (error) {
      res.send(error.message);
    }
  },

  update_notification: async (req, res) => {
    try {
      const { title, content, pubDate } = req.body;
      const notification = await notificationRef.doc(req.params.id).update({
        title: title,
        content: content,
        pubDate: pubDate,
      });
      if (!title) {
        res.status(401).send({
          message: "Title is required!",
        });
        return;
      }
      if (!content) {
        res.status(401).send({
          message: "Notification Body is required!",
        });
        return;
      }
      res.status(201).send({
        message: "Updated notification successful!",
        data: notification,
      });
    } catch (error) {
      res.status(401).send({
        message: error.message,
      });
    }
  },
};

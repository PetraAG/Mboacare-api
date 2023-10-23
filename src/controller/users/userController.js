const express = require("express");
const { Utils } = require("../../utils/firebase_init.js");
const FirebaseAuthError = require("firebase-admin");
const nodemailer = require("nodemailer");

const admin = Utils.init_files;

exports.UserController = {
  register: async (req, res) => {
    try {
      const { email, password } = req.body;
      const userResponse = await admin.auth().createUser({
        email: email,
        password: password,
        emailVerified: false,
        disabled: false,
      });

      res.status(200).send({
        message: "Account Created Successful",
        user: userResponse,
        idToken: userResponse.uid,
      });
    } catch (err) {
      console.error(err.code, err.message);
      res.status(401).send({ status: err.code, message: err.message });

      //   // Catch the FirebaseAuthError.
      //   if (error.constructor === FirebaseAuthError) {
      //     // Get the error code from the FirebaseAuthError object.
      //     const errorCode = error.code;

      //     // Switch on the error code to display a more specific error message to the user.
      //     switch (errorCode) {
      //       case "auth/email-already-in-use":
      //         res
      //           .status(errorCode)
      //           .send("The email address is already in use by another account.");
      //         break;
      //       case "auth/weak-password":
      //         res.status(errorCode).send("The password is too weak.");
      //         break;
      //       default:
      //         res.status(errorCode).send("An unexpected error occurred.");
      //         break;
      //     }
      //   }
    }
  },

  login: async (req, res) => {
    try {
      const { email, password } = req.body;

      const userRecord = await admin.auth().getUserByEmail(email);

      if (!email == userRecord.email) {
        res.status(401).send({ message: "Invalid email" });
        return;
      }
      // Compare the provided password with the user's stored password hash
      // const isPasswordValid = await bcrypt.compare(
      //   password,
      //   userRecord.passwordSalt
      // );

      // if (!isPasswordValid) {
      //   res.status(401).send({ message: "Invalid email or password" });
      //   return;
      // }
      // Generate a Firebase ID token for the user
      const token = await admin.auth().createCustomToken(userRecord.uid);

      // Send the token back to the client
      res
        .status(200)
        .send({ message: "login successful!", data: userRecord, token });
    } catch (err) {
      console.error(err.code, err.message);
      res.status(401).send({ message: "Invalid email or password" });
    }
  },

  update: async (req, res) => {
    try {
      const { uid, email, password, phoneNumber, displayName, photoURL } =
        req.body;
      const updateUserData = await admin.auth().updateUser(uid, {
        uid: uid,
        email: email,
        emailVerified: true,
        phoneNumber: phoneNumber,
        displayName: displayName,
        password: password,
        photoURL: photoURL,
      });
      res
        .status(200)
        .send({ message: "Update profile successful!", data: updateUserData });
      // res.json({
      //   message: "Account Updated Successful",
      //   user: updateUserData,
      // });
    } catch (err) {
      console.error(err.code, err.message);
      res.status(401).send({ message: err.message });
    }
  },

  reset_password: async (req, res) => {
    try {
      // const transporter = nodemailer.createTransport({
      //   service: "gmail",
      //   auth: {
      //     user: "",
      //     pass: "",
      //   },
      // });
      const email = req.body.email;

      const link = await admin.auth().generatePasswordResetLink(email);

      // Send the password reset link to the user

      // const mailOptions = {
      //   from: "Mboacare <your_email_address@gmail.com>",
      //   to: email,
      //   subject: "Reset your password",
      //   text: `Click on the following link to reset your password: ${link}`,
      // };
      // await transporter.sendMail(mailOptions);
      res.status(200).json({ message: "Check Reset password link!", link });
    } catch (error) {
      // The user does not exist or the email address is invalid
      res.status(400).json({ message: error.message });
    }
  },
};

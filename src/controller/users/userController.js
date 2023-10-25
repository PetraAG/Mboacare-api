const express = require("express");
const { Utils } = require("../../utils/firebase_init.js");
const FirebaseAuthError = require("firebase-admin");
const nodemailer = require("nodemailer");
const bcrypt = require("bcryptjs");
const admin = Utils.init_files;

exports.UserController = {
  register: async (req, res) => {
    try {
      const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: "company email",
          pass: "pass",
        },
      });

      const { email, password } = req.body;

      const saltRounds = await bcrypt.genSalt(10);
      const passwordHash = await bcrypt.hashSync(password, saltRounds);
      const userResponse = await admin.auth().createUser({
        email: email,
        password: passwordHash,
        emailVerified: false,
        disabled: false,
      });
      if (!email) {
        res.status(401).send({ message: "Email is Required!" });
        return;
      }
      if (!password) {
        res.status(401).send({ message: "Password is Required!" });
        return;
      }
      //notification to verify account
      const link = await admin.auth().generateEmailVerificationLink(email);
      const mailOptions = {
        from: "Mboacare <company email>",
        to: email,
        subject: "Email Verification",
        text: `Dear ${email}

        Thank you for signing up Mboacare! To complete your registration and verify your email address, please click on the following link: 

        ${link}

        By verifying your email, you will gain full access to all the features and benefits of our platform.
        If you did not create an account with us, please disregard this email.

        If you have any questions or need further assistance, 
        please feel free to reach out to our support team at <mboacare237@gmail.com>.

        Thank you for choosing Mboacare.

        Best regards,
        Mboacare`,
      };
      await transporter.sendMail(mailOptions);

      res.status(200).send({
        message: "Account Created Successful Check email to verify account!",
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
      if (userRecord.emailVerified == false) {
        res.status(401).send({ message: "Email is not verified!" });
        return;
      }
      if (!email) {
        res.status(401).send({ message: "Email is Required!" });
        return;
      }
      // if (!password) {
      //   res.status(401).send({ message: "Email is not verified!" });
      //   return;
      // }
      // Compare the provided password with the user's stored password hash
      // const isPasswordValid = await bcrypt.compareSync(
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
      const { uid, email, phoneNumber, displayName, photoURL } = req.body;
      const updateUserData = await admin.auth().updateUser(uid, {
        uid: uid,
        email: email,
        phoneNumber: phoneNumber,
        displayName: displayName,
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
      const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: "company email",
          pass: "pass",
        },
      });
      const email = req.body.email;

      const link = await admin.auth().generatePasswordResetLink(email);

      // Send the password reset link to the user

      const mailOptions = {
        from: "Mboacare <company email>",
        to: email,
        subject: "Password Reset Notification",
        text: `Dear ${email}

        We received a request to reset your password for your account. To proceed with the password reset,
        please click on the following link: 

        ${link}

        If you did not initiate this request, please ignore this email. Your password will remain unchanged.

        Thank you for using Mboacare.

        Best regards,
        Mboacare
        `,
      };
      await transporter.sendMail(mailOptions);
      res.status(200).json({ message: "Check email for Reset password link!" });
    } catch (error) {
      // The user does not exist or the email address is invalid
      res.status(400).json({ message: error.message });
    }
  },

  change_password: async (req, res) => {
    try {
      const { uid, email, new_password } = req.body;
      const user = await admin.auth().getUser(uid);
      console.log(user);
      const userEmail = await user.email;

      // Compare the old password and input password.
      // const isPasswordCorrect = await bcrypt.compareSync(
      //   old_password,
      //   passwordHash
      // );

      if (email != userEmail) {
        res.status(401).send({ message: "Invalid email incorrect!" });
        return;
      }
      const updateUserData = await admin.auth().updateUser(uid, {
        uid: uid,
        password: new_password,
      });

      res.status(200).send({
        message: "password changed successful!",
        data: updateUserData,
      });
      // res.json({
      //   message: "Account Updated Successful",
      //   user: updateUserData,
      // });
    } catch (err) {
      console.error(err.code, err.message);
      res.status(401).send({ message: err.message });
    }
  },

  log: async (req, res) => {
    try {
      const { uid } = req.body;
      const data = await admin.auth().getUser(uid);
      const token = await admin.auth().createCustomToken(data.uid);
      const user = await admin.auth().verifySessionCookie(token);
      res.status(200).send({
        message: "login successful!",
        data: user,
      });
    } catch (error) {
      console.error(error.code, error.message);
      res.status(401).send({ message: error.message });
    }
  },
};

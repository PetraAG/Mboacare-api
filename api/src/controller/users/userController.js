const express = require("express");
const { Utils } = require("../../utils/firebase_init.js");
const FirebaseAuthError = require("firebase-admin");
const nodemailer = require("nodemailer");
const bcrypt = require("bcryptjs");
const { Storage } = require("@google-cloud/storage");
const UUID = require("uuid-v4");
const formidable = require("formidable-serverless");
const admin = Utils.init_files;

const storage = new Storage({
  keyFilename: "serviceAccountKey.json",
});

exports.UserController = {
  register: async (req, res) => {
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        //port: 587,
        auth: {
          user: process.env.EMAIL,
          pass: process.env.PASS,
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
        from: process.env.EMAIL,
        to: email,
        subject: "Email Verification",
        html: `
       <p>Dear ${email}</p>

        <p>Thank you for signing up Mboacare! To complete your registration and verify your email address, please click on the following link:</p>

        <p>${link}</p>

        <p>By verifying your email, you will gain full access to all the features and benefits of our platform.</p>
        <p>If you did not create an account with us, please disregard this email.</p>

       <p> If you have any questions or need further assistance, </p>
       <p> please feel free to reach out to our support team at <support email></p>

       <p> Thank you for choosing Mboacare.</p>

       <p> Best regards,</p>
       <p> Mboacare.</p>`,
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

  // update: async (req, res) => {
  //   try {
  //     const { uid, phoneNumber, displayName, photoURL } = req.body;
  //     const updateUserData = await admin.auth().updateUser(uid, {
  //       uid: uid,
  //       phoneNumber: phoneNumber,
  //       displayName: displayName,
  //       photoURL: photoURL,
  //     });
  //     res
  //       .status(200)
  //       .send({ message: "Update profile successful!", data: updateUserData });
  //   } catch (err) {
  //     console.error(err.code, err.message);
  //     res.status(401).send({ message: err.message });
  //   }
  // },

  update_profile: async (req, res) => {
    const form = new formidable.IncomingForm({ multiples: true });
    try {
      form.parse(req, async (err, fields, files) => {
        let uuid = UUID();
        var downLoadPath =
          "https://firebasestorage.googleapis.com/v0/b/mboacare-api-v1.appspot.com/o/";

        const profileImage = files.profileImage;

        // url of the uploaded image
        let imageUrl;

        //const docID = blogRef.doc().id;

        if (err) {
          return res.status(400).json({
            message: "There was an error parsing the files",
            data: {},
            error: err,
          });
        }
        const bucket = storage.bucket("gs://mboacare-api-v1.appspot.com");

        if (profileImage.size == 0) {
          return res.status(400).json({
            message: "Image is required",
            data: {},
            error: err,
          });
          // do nothing
        } else {
          const imageResponse = await bucket.upload(profileImage.path, {
            destination: `blogs/${profileImage.name}`,
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
        const profileModel = {
          id: fields.id,
          name: fields.name,
          phone: fields.phone,
          profileImage: profileImage.size == 0 ? "" : imageUrl,
        };
        const updateUserData = await admin.auth().updateUser(profileModel.id, {
          uid: profileModel.id,
          phoneNumber: profileModel.phone,
          displayName: profileModel.name,
          photoURL: profileModel.profileImage,
        });
        res.status(200).send({
          message: "Update profile successful!",
          data: updateUserData,
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

  reset_password: async (req, res) => {
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        //port: 587,
        auth: {
          user: process.env.EMAIL,
          pass: process.env.PASS,
        },
      });
      const email = req.body.email;

      const link = await admin.auth().generatePasswordResetLink(email);

      // Send the password reset link to the user

      const mailOptions = {
        from: process.env.EMAIL,
        to: email,
        subject: "Password Reset Notification",
        html: `
        <p>Dear ${email}.</p>

        <p>We received a request to reset your password for your account. To proceed with the password reset,
        please click on the following link:</p> 

        <p>${link}</p>

        <p>If you did not initiate this request, please ignore this email. Your password will remain unchanged.</p>

        <p>Thank you for using Mboacare.</p>

        <p>Best regards,</p>
       <p>Mboacare</p>
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
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        //port: 587,
        auth: {
          user: process.env.EMAIL,
          pass: process.env.PASS,
        },
      });
      const { uid, email, new_password } = req.body;
      const user = await admin.auth().getUser(uid);
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
      // Send the password reset link to the user

      const mailOptions = {
        from: process.env.EMAIL,
        to: email,
        subject: "Password Update Notification",
        html: `
        <p>Dear ${email}</p>
        <p>Your password has been successfully changed.</p>
        <p>If you did not initiate this change, please contact us immediately.</p>

        <p>Thank you for using Mboacare.</p>
        <p>Best Regards,</p>

        <p>Mboacare</p>
      `,
      };
      await transporter.sendMail(mailOptions);
      res.status(200).send({
        message: "password changed successful!",
        data: updateUserData,
      });
    } catch (err) {
      console.error(err.code, err.message);
      res.status(401).send({ message: err.message });
    }
  },

  // log: async (req, res) => {
  //   try {
  //     const { email, password } = req.body;
  //     const user = await firebase.signInWithEmailAndPassword({
  //       email: email,
  //       password: password,
  //     });
  //     res.status(200).send({
  //       message: "login successful!",
  //       data: user,
  //     });
  //   } catch (error) {
  //     console.error(error.code, error.message);
  //     res.status(401).send({ message: error.message });
  //   }
  // },

  sendlink: async (req, res) => {
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        //port: 587,
        auth: {
          user: process.env.EMAIL,
          pass: process.env.PASS,
        },
      });

      const { email } = req.body;

      if (!email) {
        res.status(401).send({ message: "Email is Required!" });
        return;
      }
      //notification to verify account
      const link = await admin.auth().generateEmailVerificationLink(email);
      const mailOptions = {
        from: process.env.EMAIL,
        to: email,
        subject: "Email Verification",
        html: `
       <p>Dear ${email}</p>

        <p>Thank you for signing up Mboacare! To complete your registration and verify your email address, please click on the following link:</p>

        <p>${link}</p>

        <p>By verifying your email, you will gain full access to all the features and benefits of our platform.</p>
        <p>If you did not create an account with us, please disregard this email.</p>

       <p> If you have any questions or need further assistance, </p>
       <p> please feel free to reach out to our support team at <support email></p>

       <p> Thank you for choosing Mboacare.</p>

       <p> Best regards,</p>
       <p> Mboacare.</p>`,
      };
      await transporter.sendMail(mailOptions);

      res.status(200).send({
        message: "Account Created Successful Check email to verify account!",
      });
    } catch (err) {
      console.error(err.code, err.message);
      res.status(401).send({ status: err.code, message: err.message });
    }
  },

  getUser: async (req, res) => {
    try {
      const { email } = req.body;

      const userRecord = await admin.auth().getUserByEmail(email);

      if (!email == userRecord.email) {
        res.status(401).send({ message: "Invalid User" });
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
      res.status(200).send( userRecord );
    } catch (err) {
      console.error(err.code, err.message);
      res.status(500).send({ message: "Error retrieving user data" });
    }
  },
};

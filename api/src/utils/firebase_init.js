const admin = require("firebase-admin");
const credentials = require("../../serviceAccountKey.json");

exports.Utils = {
  init_files: admin.initializeApp({
    credential: admin.credential.cert(credentials),
  }),
};

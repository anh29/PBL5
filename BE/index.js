const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const multer = require("multer");
const path = require("path");

const app = express();
dotenv.config();

const ImageModel = require("./models/Images");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// app.use(cors());
app.use(express.json());
app.use(express.static("uploads"));

const PORT = process.env.PORT || 3000;
const MONGOURL = process.env.MONGO_URL;

const connectDB = async () => {
  await mongoose.connect(MONGOURL);

  console.log("Connect database with " + mongoose.connection.host);
};

connectDB();

const Storage = multer.diskStorage({
  destination: "uploads",
  filename: (req, file, cb) => {
    cb(
      null,
      file.fieldname + "_" + Date.now() + path.extname(file.originalname)
    );
  },
});

const upload = multer({
  storage: Storage,
});

app.post("/upload", upload.single("testImage"), (req, res) => {
  // Tạo một bản ghi mới trong cơ sở dữ liệu với dữ liệu ảnh và tên
  const newImage = new ImageModel({
    name: req.body.name,
    image: req.file.filename,
  });

  newImage
    .save()
    .then(() => {
      res.send("Upload successful!");
    })
    .catch((err) => {
      console.error(err);
      res.status(500).send("Internal Server Error");
    });
});

app.get("/getImage", (req, res) => {});

app.listen(PORT, (req, res) => {
  console.log("listening on port " + PORT);
});

const mongoose = require("mongoose");

const ImageSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  image: String,
});

const ImageModel = mongoose.model("images", ImageSchema);
module.exports = ImageModel;

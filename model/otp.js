const mongoose = require('mongoose');

// Define the OTP schema
const otpSchema = new mongoose.Schema({
  phoneNumber: {
    type: String,
    required: true,
    unique: true,
  },
  otp: {
    type: Number,
    required: true,
  },
});

// Create the OTP model using the schema
const optModel = mongoose.model('OTP', otpSchema);

module.exports = optModel;

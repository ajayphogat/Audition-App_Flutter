const mongoose = require("mongoose");

const schemaType = mongoose.Schema.Types;

let adminSchema = mongoose.Schema({
    fullName: {
        required: true,
        type: schemaType.String,
        trim: true
    },
    number: {
        required: true,
        type: schemaType.String,
        trim: true
    },
    email: {
        required: true,
        type: schemaType.String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return value.match(re);
            },
            message: "Please enter a valid email!"
        },
    },
    otpSaved: {
        type: schemaType.String,
        trim: true,
        default: ""
    },
    password: {
        required: true,
        type: schemaType.String,
    },
    promotionRequest: [
        {
            type: schemaType.ObjectId,
            ref: "post",
        }
    ]
});

const adminModel = mongoose.model("admin", adminSchema);

module.exports = adminModel;
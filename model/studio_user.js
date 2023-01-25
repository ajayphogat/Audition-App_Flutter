const mongoose = require("mongoose");

const schemaType = mongoose.Schema.Types;

let studioSchema = mongoose.Schema({
    daysLeft: {
        type: schemaType.Number,
        default: 92,
    },
    status: {
        type: schemaType.Boolean,
        default: false
    },
    createdDate: {
        type: schemaType.Date,
        default: new Date().toISOString(),
    },
    loggedInDate: {
        type: schemaType.Date
    },
    loggedOutDate: {
        type: schemaType.Date
    },
    subscriptionName: {
        type: schemaType.String,
        default: "Free"
    },
    subscriptionPrice: {
        type: schemaType.Number,
        default: 0
    },
    fname: {
        required: true,
        type: schemaType.String,
        trim: true
    },
    number: {
        required: true,
        type: schemaType.String,
        trim: true,
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
    password: {
        required: true,
        type: schemaType.String,
    },
    otpSaved: {
        type: schemaType.String,
        trim: true,
        default: ""
    },
    reported: {
        type: schemaType.Boolean,
        default: false,
    },
    location: {
        type: schemaType.String,
        trim: true,
        default: "",
    },

    profilePic: {
        type: schemaType.String,
        default: "",
    },

    views: {
        type: schemaType.Number,
        default: 0,
    },
    projectDesc: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    aboutDesc: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    followers: [
        {
            type: schemaType.ObjectId,
            ref: 'audition',
        }
    ],
    post: [
        {
            type: schemaType.ObjectId,
            ref: "post",
        }
    ],
    manager: [
        {
            type: schemaType.ObjectId,
            ref: "manager",
        }
    ],
    interview: {
        type: schemaType.Number,
        default: 0,
    }
});

const studioModel = mongoose.model("studio", studioSchema);

module.exports = studioModel;
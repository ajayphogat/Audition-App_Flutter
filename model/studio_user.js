const mongoose = require("mongoose");

const schemaType = mongoose.Schema.Types;

let studioSchema = mongoose.Schema({
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
    location: {
        type: schemaType.String,
        trim: true,
        default: "",
    },

    views: {
        type: Number,
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
});

const studioModel = mongoose.model("studio", studioSchema);

module.exports = studioModel;
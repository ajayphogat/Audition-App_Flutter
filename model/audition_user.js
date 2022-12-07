const mongoose = require("mongoose");

const schemaType = mongoose.Schema.Types;


let auditionSchema = mongoose.Schema({
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
    category: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    bio: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    //Basic Info
    pronoun: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    gender: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    location: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    profileUrl: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    profilePic: {
        type: schemaType.String,
        default: "",
    },

    visibility: {
        type: schemaType.String,
        trim: true,
        default: "public"
    },

    // Appearance
    age: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    ethnicity: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    height: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    weight: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    bodyType: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    hairColor: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    eyeColor: {
        type: schemaType.String,
        trim: true,
        default: "",
    },
    socialMedia: [
        {
            type: schemaType.String,
            default: "",

        }
    ],
    unionMembership: [
        {

            type: schemaType.String,
            default: "",

        }
    ],
    skills: [
        {

            type: schemaType.String,
            default: "",

        }
    ],
    credits: [
        {

            type: schemaType.String,

        }
    ],
    following: [
        {
            type: schemaType.ObjectId,
            ref: 'studio',
        }
    ],
    bookmark: [
        {
            type: schemaType.ObjectId,
            ref: "post",
        }
    ],
    applied: [
        {
            type: schemaType.ObjectId,
            ref: "post",
        }
    ],
    shortlisted: [
        {
            type: schemaType.ObjectId,
            ref: "post",
        }
    ],
    accepted: [
        {
            type: schemaType.ObjectId,
            ref: "post",
        }
    ],
    declined: [
        {
            type: schemaType.ObjectId,
            ref: "post",
        }
    ],
    pending: [
        {
            type: schemaType.ObjectId,
            ref: "post",
        }
    ],
    photos: [
        {
            type: schemaType.String,
            default: "",
        }
    ],
    videos: [
        {
            type: schemaType.String,
            default: "",
        }
    ],
    audios: [
        {
            type: schemaType.String,
            default: "",
        }
    ],
    documents: [
        {
            type: schemaType.String,
            default: "",
        }
    ],
    thumbnailVideo: [
        {
            type: schemaType.String,
            default: "",
        }
    ],
});

const auditionModel = mongoose.model("audition", auditionSchema);

module.exports = auditionModel;
const mongoose = require("mongoose");

const schemaType = mongoose.Schema.Types;

let postSchema = mongoose.Schema({
    promoted: {
        type: schemaType.Boolean,
        default: false
    },
    studioName: {
        type: schemaType.String,
        required: true,
        trim: true,
    },
    jobType: {
        type: schemaType.String,
        trim: true,
        required: true,
    },
    socialMedia: {
        type: schemaType.String,
        trim: true,
    },
    description: {
        type: schemaType.String,
        required: true,
        trim: true,
    },
    productionDetail: {
        type: schemaType.String,
        trim: true,
        required: true,
    },
    date: {
        type: schemaType.Date,
        required: true,
        trim: true,
    },
    location: {
        type: schemaType.String,
        required: true,
        trim: true,
    },
    contactNumber: {
        type: schemaType.Number,
        trim: true,
    },
    keyDetails: {
        type: schemaType.String,
        trim: true,
    },
    images: [
        {
            type: schemaType.String,
            required: true,
            trim: true,
        }
    ],
    studio: {
        type: schemaType.ObjectId,
        ref: "studio",
    },
    bookmark: [
        {
            type: schemaType.ObjectId,
            ref: "audition",
        }
    ],
    applicants: [
        {
            type: schemaType.ObjectId,
            ref: "audition",
        }
    ],
    shortlisted: [
        {
            type: schemaType.ObjectId,
            ref: "audition",
        }
    ],
    accepted: [
        {
            type: schemaType.ObjectId,
            ref: "audition",
        }
    ],
    declined: [
        {
            type: schemaType.ObjectId,
            ref: "audition",
        }
    ],


});

const postModel = mongoose.model("post", postSchema);

module.exports = postModel;
const mongoose = require("mongoose");

const schemaType = mongoose.Schema.Types;

let managerSchema = mongoose.Schema({
    fname: {
        required: true,
        type: schemaType.String,
        trim: true,
    },
    number: {
        required: true,
        type: schemaType.Number,
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
    url: [
        {

            type: schemaType.String,
            trim: true,


        }
    ]
});

const managerModel = mongoose.model("manager", managerSchema);

module.exports = managerModel;
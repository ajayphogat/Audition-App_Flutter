const express = require("express");
const jwt = require("jsonwebtoken");
const userJwtKey = require("../constant/const_variable");
const studioJwtKey = require("../constant/const_studio");
const userModel = require("../model/audition_user");
const studioModel = require("../model/studio_user");


const switchAuth = express.Router();

switchAuth.get("/api/switchToAudition", async (req, res) => {

    try {
        const token = req.header("x-studio-token");
        if (!token) return res.status(401).json({ msg: "No token found! Authentication Failed" });
        const verified = jwt.verify(token, studioJwtKey);
        if (!verified) return res.status(401).json({ msg: "Token verification failed! Authorization Denied" });

        const user = await studioModel.findById(verified.id);

        if (!user) return res.status(401).json({ msg: "No user found" });
        const userEmail = await studioModel.findOne({ email: user.email });
        if (!userEmail) return res.status(401).json({ msg: "No Email Found" });
        const auditionUser = await userModel.findOne({ email: user.email });
        if (!auditionUser) return res.status(401).json({ msg: "You don't have any account in Audition Portal" })
        const auditionToken = jwt.sign({ id: auditionUser._id }, userJwtKey);

        console.log({ ...auditionUser._doc, token: auditionToken });
        res.json({ ...auditionUser._doc, token: auditionToken });
    } catch (error) {
        res.status(501).json({ error: error.message });
    }

});

switchAuth.get("/api/switchToStudio", async (req, res) => {

    try {
        const token = req.header("x-auth-token");
        if (!token) return res.status(401).json({ msg: "No token found! Authentication Failed" });
        const verified = jwt.verify(token, userJwtKey);
        if (!verified) return res.status(401).json({ msg: "Token verification failed! Authorization Denied" });

        const user = await userModel.findById(verified.id);

        if (!user) return res.status(401).json({ msg: "No user found" });
        const userEmail = await userModel.findOne({ email: user.email });
        if (!userEmail) return res.status(401).json({ msg: "No Email Found" });
        const studioUser = await studioModel.findOne({ email: user.email });
        if (!studioUser) return res.status(401).json({ msg: "You don't have any account in Studio Portal" })
        const studioToken = jwt.sign({ id: studioUser._id }, studioJwtKey);

        console.log({ ...studioUser._doc, token: studioToken });
        res.json({ ...studioUser._doc, token: studioToken });
    } catch (error) {
        res.status(501).json({ error: error.message });
    }

});

module.exports = switchAuth;
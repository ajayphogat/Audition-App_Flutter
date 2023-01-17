const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const studioModel = require("../model/studio_user");
const jwtKey = require("../constant/const_studio");
const managerKey = require("../constant/const_manager");
const sAuth = require("../middleware/token_studio_validation");
const userModel = require("../model/audition_user");
const managerModel = require("../model/manager_user");

const managerAuth = express.Router();

managerAuth.post("/api/manager/signup", async (req, res) => {
    try {
        const { fname, number, email, password, userId } = req.body;
        const existingUser = await managerModel.findOne({ email });
        if (existingUser) return res.status(400).json({ msg: "User with same email already exist !" });

        const existingAudi = await userModel.findOne({ email });
        if (existingAudi) return res.status(400).json({ msg: "Email address is already registed as Audition" });

        const existingStud = await studioModel.findOne({ email });
        if (existingStud) return res.status(400).json({ msg: "Email address is already registed as Studio" });

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new managerModel({
            fname: fname,
            number: number,
            email: email,
            password: hashedPassword
        });

        user = await user.save();
        console.log(`here is user id => ${user._id}`);
        const abcd = await studioModel.findByIdAndUpdate(userId, { $push: { manager: user._id } });

        res.json({ ...user._doc });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


managerAuth.post("/api/manager/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const existingUser = await managerModel.findOne({ email });
        if (!existingUser) return res.status(400).json({ msg: "User not found!" });

        const isMatch = await bcryptjs.compare(password, existingUser.password);
        if (!isMatch) return res.status(400).json({ msg: "Incorrect Password" });

        const result = await managerModel.findOne({ email: email });
        const token = jwt.sign({ id: result._id }, managerKey);
        res.json({ token: token, ...result._doc });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

managerAuth.get("/api/manager/getAllData", async (req, res) => {
    try {
        const { email, password } = req.body;
        const token = req.header("x-manager-token");
        if (!token) return res.status(400).json({ msg: "No token found" });
        const verified = jwt.verify(token, jwtKey);
        if (!verified) return res.status(401).json({ msg: "Token verification failed!" });

        const existingUser = await managerModel.findOne({ email });
        if (!existingUser) return res.status(400).json({ msg: "User not found!" });

        res.json({ ...existingUser._doc });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// manager meeting link send function
managerAuth.post("/api/manager/sendURL", async (req, res) => {
    try {
        const { url, userId } = req.body;
        managerModel.findByIdAndUpdate(userId, { $push: { url: url } }, { new: true }, (err, result) => {
            if (err) return res.status(400).json({ error: err.message });
            res.json({ ...result._doc });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = managerAuth;
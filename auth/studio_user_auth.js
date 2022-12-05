const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const studioModel = require("../model/studio_user");
const jwtKey = require("../constant/const_studio");
const sAuth = require("../middleware/token_studio_validation");

const studioAuth = express.Router();


// Studio - Signup api
studioAuth.post("/api/studio/signup", async (req, res) => {
    try {
        const { fname, number, email, password } = req.body;
        const existingUser = await studioModel.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with same email already exist!" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new studioModel({
            fname,
            number,
            email,
            password: hashedPassword,
        });

        user = await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Audition login api
studioAuth.post("/api/studio/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const existingUser = await studioModel.findOne({ email });
        if (!existingUser) {
            return res.status(400).json({ msg: "User not found!" });
        }
        const isMatch = await bcryptjs.compare(password, existingUser.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Password!" });
        }
        const token = jwt.sign({ id: existingUser._id }, jwtKey);
        res.json({ token, ...existingUser._doc });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// token api validation
studioAuth.post("/api/studio/tokenValid", async (req, res) => {

    try {
        const token = req.header("x-studio-token");
        if (!token) {
            return res.status(401).json(false);
        }
        const verified = jwt.verify(token, jwtKey);
        if (!verified) {
            return res.status(401).json(false);
        }
        const user = await studioModel.findById(verified.id);
        if (!user) {
            return res.status(401).json(false);
        }

        res.json(true);
    } catch (error) {
        res.status(501).json({ error: error.message });
    }

});

// Audition get user data api
studioAuth.get("/api/studio/getUserData", sAuth, async (req, res) => {
    try {
        const user = await studioModel.findById(req.user);
        if (!user) {
            return res.status(401).json({ msg: "No user found" });
        }

        console.log({ ...user._doc, token: req.token });
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

studioAuth.post("/api/studio/updateNameLoc", sAuth, async (req, res) => {
    try {
        const { fname, location } = req.body;
        let user = await studioModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateNameLoc = await studioModel.updateOne({ _id: req.user }, { $set: { fname: fname, location: location } });
        if (updateNameLoc.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save! Try Again" });
        }
        user = await studioModel.findById(req.user);
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


studioAuth.post("/api/studio/updateProjectDesc", sAuth, async (req, res) => {
    try {
        const { projectDesc } = req.body;
        let user = await studioModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateProjectDesc = await studioModel.updateOne({ _id: req.user }, { $set: { projectDesc: projectDesc } });
        if (updateProjectDesc.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save! Try Again" });
        }
        user = await studioModel.findById(req.user);
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


studioAuth.post("/api/studio/updateAboutDesc", sAuth, async (req, res) => {
    try {
        const { aboutDesc } = req.body;
        let user = await studioModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateAboutDesc = await studioModel.updateOne({ _id: req.user }, { $set: { aboutDesc: aboutDesc } });
        if (updateAboutDesc.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save! Try Again" });
        }
        user = await studioModel.findById(req.user);
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

studioAuth.get("/api/getStudioData", sAuth, async (req, res) => {

    try {
        let totalApplicants = 0;
        let totalShortlisted = 0;
        let totalAccepted = 0;
        let totalDeclined = 0;
        let totalBookmark = 0;
        studioModel.findById(req.user).then(user => {
            studioModel.findById(req.user).populate("post").exec(function (error, result) {
                console.log("hey");
                console.log("hey");
                console.log("hey");
                console.log("hey");
                console.log("hey");
                console.log("hey");
                // console.log(result.post.length);
                console.log("yo yo yo yo")
                console.log("yo yo yo yo")
                console.log("yo yo yo yo")
                console.log("yo yo yo yo")
                console.log("yo yo yo yo")
                console.log("yo yo yo yo")
                console.log("yo yo yo yo")

                for (let index = 0; index < result.post.length; index++) {
                    totalApplicants = totalApplicants + result.post[index].applicants.length;
                }
                for (let index = 0; index < result.post.length; index++) {
                    totalShortlisted = totalShortlisted + result.post[index].shortlisted.length;
                }
                for (let index = 0; index < result.post.length; index++) {
                    totalAccepted = totalAccepted + result.post[index].accepted.length;
                }
                for (let index = 0; index < result.post.length; index++) {
                    totalDeclined = totalDeclined + result.post[index].declined.length;
                }
                for (let index = 0; index < result.post.length; index++) {
                    totalBookmark = totalBookmark + result.post[index].bookmark.length;
                }

                console.log({ ...result._doc, token: req.token, totalAccepted: totalAccepted, totalApplicants: totalApplicants, totalBookmark: totalBookmark, totalShortlisted: totalShortlisted });
                // let shortt = ({ ...result._doc.post[0]._doc.applicants });
                // console.log(shortt);
                // console.log(result.post[0].studioName);
                // console.log({ ...result._doc.post[0]._doc.shortlisted })
                // console.log({ ...result._doc, token: req.token });
                res.json({ ...result._doc, token: req.token, totalAccepted: totalAccepted.toString(), totalApplicants: totalApplicants.toString(), totalBookmark: totalBookmark.toString(), totalShortlisted: totalShortlisted.toString() });
            })

        }).catch((err) => {
            res.status(501).json({ error: err.message });
        });

    } catch (error) {

    }
})

module.exports = studioAuth;
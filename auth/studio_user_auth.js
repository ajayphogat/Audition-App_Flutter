const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const studioModel = require("../model/studio_user");
const jwtKey = require("../constant/const_studio");
const sAuth = require("../middleware/token_studio_validation");
const userModel = require("../model/audition_user");

const studioAuth = express.Router();


// Studio - Signup api
studioAuth.post("/api/studio/signup", async (req, res) => {
    try {
        let firebaseCreate;
        const { fname, number, email, password } = req.body;
        const existingUser = await studioModel.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with same email already exist!" });
        }
        const existingAudition = await userModel.findOne({ email });
        if (existingAudition) {
            firebaseCreate = false;
        }
        else {
            firebaseCreate = true;
        }
        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new studioModel({
            fname,
            number,
            email,
            password: hashedPassword,
        });

        user = await user.save();
        res.json({ ...user._doc, created: firebaseCreate });
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

                let newMonth = result.post[0].date.toISOString().split('T')[0].split('-')[1];
                let newDay = result.post[0].date.toISOString().split('T')[0].split('-')[2];
                let newYear = result.post[0].date.toISOString().split('T')[0].split('-')[0];
                console.log(newMonth);
                console.log(newDay);
                console.log(newYear);

                let janJob = 0;
                let febJob = 0;
                let marJob = 0;
                let aprJob = 0;
                let mayJob = 0;
                let junJob = 0;
                let julJob = 0;
                let augJob = 0;
                let sepJob = 0;
                let octJob = 0;
                let novJob = 0;
                let decJob = 0;

                let janApplicants = 0;
                let febApplicants = 0;
                let marApplicants = 0;
                let aprApplicants = 0;
                let mayApplicants = 0;
                let junApplicants = 0;
                let julApplicants = 0;
                let augApplicants = 0;
                let sepApplicants = 0;
                let octApplicants = 0;
                let novApplicants = 0;
                let decApplicants = 0;

                for (let index = 0; index < result.post.length; index++) {
                    const element = result.post[index];
                    if (element.date.toISOString().split('T')[0].split('-')[1] == 1) {
                        janJob += 1;
                        janApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 2) {
                        febJob += 1;
                        febApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 3) {
                        marJob += 1;
                        marApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 4) {
                        aprJob += 1;
                        aprApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 5) {
                        mayJob += 1;
                        mayApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 6) {
                        junJob += 1;
                        junApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 7) {
                        julJob += 1;
                        julApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 8) {
                        augJob += 1;
                        augApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 9) {
                        sepJob += 1;
                        sepApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 10) {
                        octJob += 1;
                        octApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 11) {
                        novJob += 1;
                        novApplicants += element.applicants.length;
                    }
                    else if (element.date.toISOString().split('T')[0].split('-')[1] == 12) {
                        decJob += 1;
                        decApplicants += element.applicants.length;

                    }


                }


                console.log(decJob);
                console.log(decApplicants);
                // console.log(d.getUTCMonth() + 1);
                console.log("result date");
                console.log({ janJob: janJob, febJob: febJob, marJob: marJob, aprJob: aprJob, mayJob: mayJob, junJob: junJob, julJob: julJob, augJob: augJob, sepJob: sepJob, octJob: octJob, novJob: novJob, decJob: decJob, janApplicants: janApplicants, febApplicants: febApplicants, marApplicants: marApplicants, aprApplicants: aprApplicants, mayApplicants: mayApplicants, junApplicants: junApplicants, julApplicants: julApplicants, augApplicants: augApplicants, sepApplicants: sepApplicants, octApplicants: octApplicants, novApplicants: novApplicants, decApplicants: decApplicants });
                // console.log({ ...result._doc, token: req.token, totalAccepted: totalAccepted, totalApplicants: totalApplicants, totalBookmark: totalBookmark, totalShortlisted: totalShortlisted });
                // let shortt = ({ ...result._doc.post[0]._doc.applicants });
                // console.log(shortt);
                // console.log(result.post[0].studioName);
                // console.log({ ...result._doc.post[0]._doc.shortlisted })
                // console.log({ ...result._doc, token: req.token });
                res.json({ ...result._doc, token: req.token, totalAccepted: totalAccepted.toString(), totalApplicants: totalApplicants.toString(), totalBookmark: totalBookmark.toString(), totalShortlisted: totalShortlisted.toString(), janJob: janJob, febJob: febJob, marJob: marJob, aprJob: aprJob, mayJob: mayJob, junJob: junJob, julJob: julJob, augJob: augJob, sepJob: sepJob, octJob: octJob, novJob: novJob, decJob: decJob, janApplicants: janApplicants, febApplicants: febApplicants, marApplicants: marApplicants, aprApplicants: aprApplicants, mayApplicants: mayApplicants, junApplicants: junApplicants, julApplicants: julApplicants, augApplicants: augApplicants, sepApplicants: sepApplicants, octApplicants: octApplicants, novApplicants: novApplicants, decApplicants: decApplicants });
            })

        }).catch((err) => {
            res.status(501).json({ error: err.message });
        });

    } catch (error) {

    }
});


// profilePic upload
studioAuth.post("/api/upload/studio/profilePic", sAuth, async (req, res) => {
    try {
        console.log(req.body.profilePicUrl);
        console.log("Studio");

        await studioModel.findByIdAndUpdate(req.user, { $set: { profilePic: req.body.profilePicUrl } }).then(user => {
            studioModel.findById(req.user).exec(function (error, result) {
                console.log({ ...result._doc, token: "" });
                res.json({ ...result._doc, token: req.token });
            });
        })

        // await userModel.findByIdAndUpdate(req.user, { $set: { profilePic: req.body.profilePicUrl } }, { new: true }, (error, result) => {
        //     if (error) return res.status(401).json({ msg: error.message });
        //     console.log("heheheheheh");
        //     console.log("heheheheheh");
        //     console.log("heheheheheh");
        //     console.log("heheheheheh");
        //     console.log("heheheheheh");
        //     console.log(result);
        //     console.log(req.body.profilePicUrl);
        //     res.json({ "msg": yes });
        // });
    } catch (error) {
        res.status(501).json({ error: error.message });
    }
});


// get studio details with populate
studioAuth.get("/api/showFollowers", sAuth, async (req, res) => {
    try {
        // const working = req.query.working;
        studioModel.findById(req.user).then(user => {
            studioModel.findById(req.user).populate("followers").exec(function (error, result) {
                // if (error) return res.status(401).json({ msg: error.message });

                console.log(result);
                res.json(result);
            })
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

module.exports = studioAuth;
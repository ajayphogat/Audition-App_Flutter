const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const studioModel = require("../model/studio_user");
const jwtKey = require("../constant/const_studio");
const sAuth = require("../middleware/token_studio_validation");
const auth = require("../middleware/token_validation");
const postModel = require("../model/job_post");
const userModel = require("../model/audition_user");

const postJob = express.Router();

postJob.post("/api/postJob", sAuth, async (req, res) => {

    try {
        const { studioName, jobType, socialMedia, description, productionDetail, date, location, contactNumber, keyDetails, images, applicants } = req.body;

        let user = await studioModel.findById(req.user);
        console.log("Hello");
        console.log(req.user);
        console.log(user);
        if (!user) return res.status(401).json({ msg: "No user found" });

        let newDate = Date(date);

        const postNewJob = postModel({ studioName: studioName, jobType: jobType, socialMedia: socialMedia, description: description, productionDetail: productionDetail, date: newDate, location: location, contactNumber: contactNumber, keyDetails: keyDetails, images: images, studio: req.user, applicants: applicants });
        postNewJob.save().then(reUse => {
            console.log(reUse);
            studioModel.findByIdAndUpdate(req.user, { $push: { post: reUse._id } }, { new: true }, (error, result) => {
                if (error) return res.status(401).json({ msg: error.message });
                res.json(result);
            })
        }).catch((err) => {
            console.log(err.message);
        });







        // if (postNewJob.acknowledged == false) {
        //     return res.status(401).json({ msg: "Can't save! Try again" });
        // }

        // // let newPost = await postModel.find();
        // console.log(newPost);
        // res.json(newPost);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});

postJob.get("/api/getJob", auth, async (req, res) => {

    try {

        let user = await userModel.findById(req.user);
        if (!user) return res.status(401).json({ msg: "No user found" });

        const allJobs = await postModel.find().populate("studio").exec(function (error, result) {
            if (error) return res.status(401).json({ msg: error.message });
            console.log(result);
            return res.json(result);
        })
        // res.json(allJobs);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});


postJob.get("/api/getStudioJob", sAuth, async (req, res) => {

    try {
        console.log("abcd");
        console.log("abcd");
        console.log("abcd");
        console.log("abcd");

        studioModel.findById(req.user).then(result => {

            postModel.find({ studio: req.user }).populate("studio").exec(function (error, result) {
                if (error) return res.status(401).json({ msg: error.message });
                console.log("result");
                console.log("result");
                console.log("result");
                console.log("result");
                console.log("result");
                console.log("result");
                console.log(result);
                res.json(result);
            })
        })

        // res.json(allJobs);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});


postJob.get("/api/getCategoryJob", auth, async (req, res) => {

    try {
        const category = req.query.category;
        const search = req.query.search;
        console.log(search);
        let newResult = [];
        let user = await userModel.findById(req.user);
        if (!user) return res.status(401).json({ msg: "No user found" });

        let a = await postModel.find({ jobType: category }).populate('studio').exec(function (error, result) {
            if (error) return res.status(401).json({ msg: error.message });

            if (search.length > 0) {
                result.forEach(element => {
                    if (element.studioName.toLowerCase() == search.toLowerCase()) {
                        newResult.push(element);
                    }

                });
                return res.json(newResult);
            }
            console.log("hey hey hey");
            console.log("hey hey hey");
            console.log("hey hey hey");
            console.log("hey hey hey");
            console.log(newResult);
            console.log(result);
            console.log(category);
            console.log("he");
            console.log(search);
            return res.json(result);
        })
        // res.json(allJobs);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});


postJob.get("/api/getOneJobDetail", auth, async (req, res) => {

    try {
        console.log(req.query.jobId);
        const jobId = req.query.jobId;
        let isFollowed;
        let isBookmarked;
        let isApplied;
        let user = await userModel.findById(req.user);
        if (!user) return res.status(401).json({ msg: "No user found" });

        let a = await postModel.findOne({ _id: jobId }).populate('studio').exec(function (error, result) {
            if (error) return res.status(401).json({ msg: error.message });
            console.log(result.bookmark);
            if (result.studio.followers.filter(followers => followers.toString() === req.user).length == 1) {
                isFollowed = true;
            }
            else {
                isFollowed = false;
            }
            if (result.bookmark.filter(book => book.toString() === req.user).length == 1) {
                isBookmarked = true;
            }
            else {
                isBookmarked = false;
            }
            if (result.applicants.filter(appliedPersons => appliedPersons.toString() === req.user).length == 1) {
                isApplied = true;
            }
            else {
                isApplied = false;
            }
            console.log({ ...result._doc, isFollowed: isFollowed, isBookmarked: isBookmarked, isApplied: isApplied });
            return res.json({ ...result._doc, isFollowed: isFollowed, isBookmarked: isBookmarked, isApplied: isApplied });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});
postJob.get("/api/getOneStudioJobDetail", sAuth, async (req, res) => {

    try {
        console.log(req.query.jobId);
        const jobId = req.query.jobId;
        let isFollowed;
        let isBookmarked;
        let user = await studioModel.findById(req.user);
        if (!user) return res.status(401).json({ msg: "No user found" });

        let a = await postModel.findOne({ _id: jobId }).populate('studio').exec(function (error, result) {
            if (error) return res.status(401).json({ msg: error.message });
            console.log(result.bookmark);
            if (result.studio.followers.filter(followers => followers.toString() === req.user).length == 1) {
                isFollowed = true;
            }
            else {
                isFollowed = false;
            }
            if (result.bookmark.filter(book => book.toString() === req.user).length == 1) {
                isBookmarked = true;
            }
            else {
                isBookmarked = false;
            }
            if (result.applicants.filter(appliedPersons => appliedPersons.toString() === req.user).length == 1) {
                isApplied = true;
            }
            else {
                isApplied = false;
            }
            console.log({ ...result._doc, isFollowed: isFollowed, isBookmarked: isBookmarked, isApplied: isApplied });
            return res.json({ ...result._doc, isFollowed: isFollowed, isBookmarked: isBookmarked, isApplied: isApplied });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});


postJob.get("/api/studio/getOneStudioJobDetail", sAuth, async (req, res) => {

    try {
        console.log(req.query.jobId);
        const jobId = req.query.jobId;
        let isFollowed;
        let isBookmarked;
        let isApplied;
        let user = await studioModel.findById(req.user);
        if (!user) return res.status(401).json({ msg: "No user found" });

        let a = await postModel.findOne({ _id: jobId }).populate('applicants').exec(function (error, result) {
            if (error) return res.status(401).json({ msg: error.message });
            console.log(result.applicants);
            // if (result.studio.followers.filter(followers => followers.toString() === req.user).length == 1) {
            //     isFollowed = true;
            // }
            // else {
            //     isFollowed = false;
            // }
            // if (result.bookmark.filter(book => book.toString() === req.user).length == 1) {
            //     isBookmarked = true;
            // }
            // else {
            //     isBookmarked = false;
            // }
            // if (result.applicants.filter(appliedPersons => appliedPersons.toString() === req.user).length == 1) {
            //     isApplied = true;
            // }
            // else {
            //     isApplied = false;
            // }
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log(result.applicants);
            return res.json(result.applicants);
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});
postJob.get("/api/studio/getOneAcceptedJobDetail", sAuth, async (req, res) => {

    try {
        console.log(req.query.jobId);
        const jobId = req.query.jobId;
        let isFollowed;
        let isBookmarked;
        let isApplied;
        let user = await studioModel.findById(req.user);
        if (!user) return res.status(401).json({ msg: "No user found" });

        let a = await postModel.findOne({ _id: jobId }).populate('accepted').exec(function (error, result) {
            if (error) return res.status(401).json({ msg: error.message });
            console.log(result.accepted);
            // if (result.studio.followers.filter(followers => followers.toString() === req.user).length == 1) {
            //     isFollowed = true;
            // }
            // else {
            //     isFollowed = false;
            // }
            // if (result.bookmark.filter(book => book.toString() === req.user).length == 1) {
            //     isBookmarked = true;
            // }
            // else {
            //     isBookmarked = false;
            // }
            // if (result.applicants.filter(appliedPersons => appliedPersons.toString() === req.user).length == 1) {
            //     isApplied = true;
            // }
            // else {
            //     isApplied = false;
            // }
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log(result.accepted);
            return res.json(result.accepted);
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});

postJob.get("/api/studio/getOneShortlistedJobDetail", sAuth, async (req, res) => {

    try {
        console.log(req.query.jobId);
        const jobId = req.query.jobId;
        let isFollowed;
        let isBookmarked;
        let isApplied;
        let user = await studioModel.findById(req.user);
        if (!user) return res.status(401).json({ msg: "No user found" });

        let a = await postModel.findOne({ _id: jobId }).populate('shortlisted').exec(function (error, result) {
            if (error) return res.status(401).json({ msg: error.message });
            console.log(result.shortlisted);
            // if (result.studio.followers.filter(followers => followers.toString() === req.user).length == 1) {
            //     isFollowed = true;
            // }
            // else {
            //     isFollowed = false;
            // }
            // if (result.bookmark.filter(book => book.toString() === req.user).length == 1) {
            //     isBookmarked = true;
            // }
            // else {
            //     isBookmarked = false;
            // }
            // if (result.applicants.filter(appliedPersons => appliedPersons.toString() === req.user).length == 1) {
            //     isApplied = true;
            // }
            // else {
            //     isApplied = false;
            // }
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log("heyyyyyy");
            console.log(result.shortlisted);
            return res.json(result.shortlisted);
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }

});





module.exports = postJob;
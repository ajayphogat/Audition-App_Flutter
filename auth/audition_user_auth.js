const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const userModel = require("../model/audition_user");
const auth = require("../middleware/token_validation");
const jwtKey = require("../constant/const_variable");
const studioModel = require("../model/studio_user");
const postModel = require("../model/job_post");
const sAuth = require("../middleware/token_studio_validation");


const userAuth = express.Router();


// Audition - Signup api
userAuth.post("/api/audition/signup", async (req, res) => {
    try {
        const { fname, number, email, password } = req.body;
        const existingUser = await userModel.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with same email already exist!" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new userModel({
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
userAuth.post("/api/audition/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const existingUser = await userModel.findOne({ email });
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

// Audition token validation api
userAuth.post("/api/tokenValid", async (req, res) => {

    try {
        const token = req.header("x-auth-token");
        if (!token) {
            return res.status(401).json(false);
        }
        const verified = jwt.verify(token, jwtKey);
        if (!verified) {
            return res.status(401).json(false);
        }
        const user = await userModel.findById(verified.id);
        if (!user) {
            return res.status(401).json(false);
        }

        res.json(true);
    } catch (error) {
        res.status(501).json({ error: error.message });
    }

});

// Audition get user data api
userAuth.get("/api/audition/getUserData", auth, async (req, res) => {
    try {
        console.log("get user data");
        const user = await userModel.findById(req.user);
        if (!user) {
            return res.status(401).json({ msg: "No user found" });
        }
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// Change Bio
userAuth.post("/api/audition/changeBio", auth, async (req, res) => {
    try {
        const { bio } = req.body;
        let user = await userModel.findById(req.user);
        if (!user) {
            return res.status(401).json({ msg: "No user found" });
        }
        const updatedBio = await userModel.updateOne({ _id: req.user }, { $set: { bio: bio } });
        user = await userModel.findById(req.user);
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/audition/updateBasicInfo", auth, async (req, res) => {
    try {
        const { fname, pronoun, gender, location, profileUrl, category, visibility } = req.body;
        let user = await userModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateBasicInfo = await userModel.updateOne({ _id: req.user }, { $set: { fname: fname, pronoun: pronoun, gender: gender, location: location, profileUrl: profileUrl, category: category, visibility: visibility } });
        if (updateBasicInfo.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save Basic Info" });
        }
        user = await userModel.findById(req.user);
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/audition/updateAppearance", auth, async (req, res) => {
    try {
        const { age, ethnicity, height, weight, bodyType, hairColor, eyeColor } = req.body;
        let user = await userModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateAppearance = await userModel.updateOne({ _id: req.user }, { $set: { age, ethnicity, height, weight, bodyType, hairColor, eyeColor } });
        if (updateAppearance.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save Appearance Data" });
        }
        user = await userModel.findById(req.user);
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/audition/updateSocialMedia", auth, async (req, res) => {
    try {
        const socialMedia = req.body;
        let user = await userModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateSocialMedia = await userModel.updateOne({ _id: req.user }, { $set: { socialMedia } });
        if (updateSocialMedia.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save Appearance Data" });
        }
        user = await userModel.findById(req.user);
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/audition/updateUnionMembership", auth, async (req, res) => {
    try {
        const unionMembership = req.body;
        console.log(unionMembership);
        let user = await userModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateUnionMembership = await userModel.updateOne({ _id: req.user }, { $set: { unionMembership } });
        if (updateUnionMembership.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save Appearance Data" });
        }
        user = await userModel.findById(req.user);
        console.log({ ...user._doc, token: req.token });
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


userAuth.post("/api/audition/updateSkills", auth, async (req, res) => {
    try {
        const skills = req.body;
        console.log(skills);
        let user = await userModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateSkills = await userModel.updateOne({ _id: req.user }, { $set: { skills } });
        if (updateSkills.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save Appearance Data" });
        }
        user = await userModel.findById(req.user);
        console.log({ ...user._doc, token: req.token });
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
userAuth.post("/api/audition/updateCredits", auth, async (req, res) => {
    try {
        const credits = req.body;
        console.log(credits);
        let user = await userModel.findById(req.user);
        if (!user) {
            return res.status(400).json({ msg: "No user found" });
        }
        const updateCredits = await userModel.updateOne({ _id: req.user }, { $set: { credits } });
        if (updateCredits.acknowledged == false) {
            return res.status(400).json({ msg: "Can't save Appearance Data" });
        }
        user = await userModel.findById(req.user);
        console.log({ ...user._doc, token: req.token });
        res.json({ ...user._doc, token: req.token });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


userAuth.post("/api/audition/follow", auth, async (req, res) => {

    try {
        const toFollowId = req.body.toFollowId;
        const jobId = req.body.jobId;
        console.log(toFollowId);
        console.log(jobId);

        const studioUser = await studioModel.findById(toFollowId);
        userModel.findById(req.user).then(user => {
            if ((user.following.filter(followings => followings.toString() === toFollowId).length == 0) && (studioUser)) {
                console.log("inside ");
                userModel.findByIdAndUpdate(req.user, { $push: { following: toFollowId } }, { new: true }, (err, result) => {

                    if (err) return res.status(401).json({ msg: err.message })

                    studioModel.findByIdAndUpdate(toFollowId, { $push: { followers: req.user } }, { new: true }, (error, results) => {

                        if (error) return res.status(401).json({ msg: error.message })
                        // console.log(results);
                        // res.json(results)

                        postModel.findOne({ _id: jobId }).populate('studio').exec(function (error, result) {
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
                    });
                })


            }
            else {
                return res.status(401).json({ msg: "Already Followed" });
            }
        })

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/audition/unfollow", auth, async (req, res) => {

    try {
        const toFollowId = req.body.toFollowId;
        const jobId = req.body.jobId;
        console.log(jobId);
        console.log(toFollowId);
        studioUser = studioModel.findById(toFollowId);
        await userModel.findById(req.user).then(user => {
            if ((user.following.filter(followings => followings.toString() === toFollowId).length > 0) && (studioUser)) {
                console.log("inside");
                userModel.findByIdAndUpdate(req.user, { $pull: { following: toFollowId } }, { new: true }, (err, result) => {

                    if (err) return res.status(401).json({ msg: err.message })

                    studioModel.findByIdAndUpdate(toFollowId, { $pull: { followers: req.user } }, { new: true }, (error, results) => {
                        if (error) return res.status(401).json({ msg: error.message })
                        // res.json({ results, result })

                        postModel.findOne({ _id: jobId }).populate('studio').exec(function (error, result) {
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
                    });
                })


            }
            else {
                return res.status(401).json({ msg: "Already unfollowed" });
            }
        })

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/audition/bookmark", auth, async (req, res) => {

    try {
        const jobPostId = req.body.jobPostId;
        const jobPost = postModel.findById(jobPostId);
        if (!jobPost) {
            return res.status(401).json({ msg: "No Job found" });
        }
        userModel.findById(req.user).then(user => {
            if (user.bookmark.filter(bookmarks => bookmarks.toString() === jobPostId).length == 0) {
                console.log("inside");
                userModel.findByIdAndUpdate(req.user, { $push: { bookmark: jobPostId } }, { new: true }, (error, result) => {
                    console.log("inside push");
                    if (error) return res.status(401).json({ msg: error.message });
                    postModel.findByIdAndUpdate(jobPostId, { $push: { bookmark: req.user } }, { new: true }, (err, results) => {
                        if (err) return res.status(401).json({ msg: err.message });
                        // res.json({ result, results });

                        console.log("before post model");
                        postModel.findOne({ _id: jobPostId }).populate('studio').exec(function (error, result) {
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
                    })

                })

            }
            else {
                console.log(user.bookmark);
                return res.status(401).json({ msg: "Already Bookmarked" });
            }
        })

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/audition/undoBookmark", auth, async (req, res) => {

    try {
        const jobPostId = req.body.jobPostId;
        const jobPost = postModel.findById(jobPostId);
        if (!jobPost) {
            return res.status(401).json({ msg: "No Job found" });
        }
        userModel.findById(req.user).then(user => {
            if (user.bookmark.filter(bookmarks => bookmarks.toString() === jobPostId).length > 0) {
                userModel.findByIdAndUpdate(req.user, { $pull: { bookmark: jobPostId } }, { new: true }, (error, result) => {
                    if (error) return res.status(401).json({ msg: error.message });
                    postModel.findByIdAndUpdate(jobPostId, { $pull: { bookmark: req.user } }, { new: true }, (err, results) => {
                        if (err) return res.status(401).json({ msg: err.message })
                        // res.json({ result, results });

                        postModel.findOne({ _id: jobPostId }).populate('studio').exec(function (error, result) {
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
                            } if (result.applicants.filter(appliedPersons => appliedPersons.toString() === req.user).length == 1) {
                                isApplied = true;
                            }
                            else {
                                isApplied = false;
                            }
                            console.log({ ...result._doc, isFollowed: isFollowed, isBookmarked: isBookmarked, isApplied: isApplied });
                            return res.json({ ...result._doc, isFollowed: isFollowed, isBookmarked: isBookmarked, isApplied: isApplied });
                        })
                    })
                })
            }
            else {
                return res.status(401).json({ msg: "Already Removed Bookmark" });
            }
        })

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});



userAuth.post("/api/audition/applyJob", auth, async (req, res) => {

    try {
        const jobPostId = req.body.jobPostId;
        const jobPost = postModel.findById(jobPostId);
        if (!jobPost) {
            return res.status(401).json({ msg: "No Job found" });
        }
        userModel.findById(req.user).then(user => {
            if (user.applied.filter(appliedJob => appliedJob.toString() === jobPostId).length == 0) {
                console.log("inside");
                userModel.findByIdAndUpdate(req.user, { $push: { applied: jobPostId } }, { new: true }, (error, result) => {
                    console.log("inside push");
                    if (error) return res.status(401).json({ msg: error.message });
                    postModel.findByIdAndUpdate(jobPostId, { $push: { applicants: req.user } }, { new: true }, (err, results) => {
                        if (err) return res.status(401).json({ msg: err.message });
                        // res.json({ result, results });

                        console.log("before post model");
                        postModel.findOne({ _id: jobPostId }).populate("studio").exec(function (error, result) {
                            console.log('hehehe');
                            console.log(result);
                            if (error) return res.status(401).json({ msg: error.message });
                            // console.log(error.message);
                            if (result.studio.followers.filter(followers => followers.toString() === req.user).length == 1) {
                                isFollowed = true;
                                console.log("follow");
                            }
                            else {
                                isFollowed = false;
                            }
                            if (result.bookmark.filter(book => book.toString() === req.user).length == 1) {
                                isBookmarked = true;
                                console.log("book");
                            }
                            else {
                                isBookmarked = false;
                            }
                            if (result.applicants.filter(appliedPersons => appliedPersons.toString() === req.user).length == 1) {
                                isApplied = true;
                                console.log("applied");
                            }
                            else {
                                isApplied = false;
                            }
                            console.log({ ...result._doc, isFollowed: isFollowed, isBookmarked: isBookmarked, isApplied: isApplied });
                            return res.json({ ...result._doc, isFollowed: isFollowed, isBookmarked: isBookmarked, isApplied: isApplied });
                        })
                    })

                })

            }
            else {
                console.log(user.bookmark);
                return res.status(401).json({ msg: "Already Bookmarked" });
            }
        })

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/studio/acceptJob", sAuth, async (req, res) => {

    try {
        const jobPostId = req.body.jobPostId;
        const jobPost = postModel.findById(jobPostId);
        const work = req.body.work;

        if (!jobPost) {
            return res.status(401).json({ msg: "No Job found" });
        }

        if (work == "Accepted") {
            userModel.findById(req.body.userId).then(user => {
                if (user.accepted.filter(acceptedJob => acceptedJob.toString() === jobPostId).length == 0) {
                    console.log("inside");
                    userModel.findByIdAndUpdate(req.body.userId, { $push: { accepted: jobPostId } }, { new: true }, (error, result) => {
                        userModel.findByIdAndUpdate(req.body.userId, { $pull: { shortlisted: jobPostId, declined: jobPostId, pending: jobPostId } }, { new: true }, (error, result) => {
                            console.log("inside push");
                            if (error) return res.status(401).json({ msg: error.message });
                            postModel.findByIdAndUpdate(jobPostId, { $push: { accepted: req.body.userId } }, { new: true }, (err, results) => {
                                if (err) return res.status(401).json({ msg: err.message });
                                // res.json({ result, results });

                                postModel.findByIdAndUpdate(jobPostId, { $pull: { shortlisted: req.body.userId, declined: req.body.userId } }, { new: true }, (err, results) => {
                                    console.log("before post model");
                                    postModel.findOne({ _id: jobPostId }).exec(function (error, result) {
                                        console.log('hehehe');
                                        console.log(result);
                                        if (error) return res.status(401).json({ msg: error.message });


                                        if (result.accepted.filter(acceptedJob => acceptedJob.toString() === req.body.userId).length == 1) {
                                            isAccepted = true;
                                            console.log("accepted");
                                        }
                                        else {
                                            isAccepted = false;
                                        }
                                        if (result.shortlisted.filter(shortJob => shortJob.toString() === req.body.userId).length == 1) {
                                            isShortlisted = true;
                                            console.log("shortlisted");
                                        }
                                        else {
                                            isShortlisted = false;
                                        }
                                        if (result.declined.filter(declineJob => declineJob.toString() === req.body.userId).length == 1) {
                                            isDeclined = true;
                                            console.log("declined");
                                        }
                                        else {
                                            isDeclined = false;
                                        }
                                        console.log("before accepted button");
                                        console.log({ ...result._doc, isAccepted: isAccepted, isShortlisted: isShortlisted, isDeclined: isDeclined });
                                        return res.json({ ...result._doc, isAccepted: isAccepted, isShortlisted: isShortlisted, isDeclined: isDeclined });
                                        // if (result.accepted.filter(acceptedJob => acceptedJob.toString() === req.body.userId).length == 1) {
                                        //     isAccepted = true;
                                        //     console.log("accepted");
                                        // }
                                        // else {
                                        //     isAccepted = false;
                                        // }
                                        // console.log("after accepted");
                                        // console.log(req.body.userId);
                                        // console.log({ ...result._doc, isAccepted: isAccepted });
                                        // return res.json({ ...result._doc, isAccepted: isAccepted });
                                    })
                                });


                            })
                        })


                    })

                }
                else {
                    return res.status(401).json({ msg: "Already Accepted" });
                }
            })


        }
        else if (work == "Shortlisted") {
            userModel.findById(req.body.userId).then(user => {
                if (user.shortlisted.filter(shortlistedJob => shortlistedJob.toString() === jobPostId).length == 0) {
                    console.log("inside");
                    userModel.findByIdAndUpdate(req.body.userId, { $push: { shortlisted: jobPostId } }, { new: true }, (error, result) => {
                        userModel.findByIdAndUpdate(req.body.userId, { $pull: { accepted: jobPostId, declined: jobPostId } }, { new: true }, (error, result) => {
                            console.log("inside push");

                            if (error) return res.status(401).json({ msg: error.message });
                            postModel.findByIdAndUpdate(jobPostId, { $push: { shortlisted: req.body.userId } }, { new: true }, (err, results) => {
                                if (err) return res.status(401).json({ msg: err.message });
                                // res.json({ result, results });

                                postModel.findByIdAndUpdate(jobPostId, { $pull: { accepted: req.body.userId, declined: req.body.userId } }, { new: true }, (err, results) => {
                                    console.log("before post model");
                                    postModel.findOne({ _id: jobPostId }).exec(function (error, result) {
                                        console.log('hehehe');
                                        console.log(result);
                                        if (error) return res.status(401).json({ msg: error.message });


                                        if (result.accepted.filter(acceptedJob => acceptedJob.toString() === req.body.userId).length == 1) {
                                            isAccepted = true;
                                            console.log("accepted");
                                        }
                                        else {
                                            isAccepted = false;
                                        }
                                        if (result.shortlisted.filter(shortJob => shortJob.toString() === req.body.userId).length == 1) {
                                            isShortlisted = true;
                                            console.log("shortlisted");
                                        }
                                        else {
                                            isShortlisted = false;
                                        }
                                        if (result.declined.filter(declineJob => declineJob.toString() === req.body.userId).length == 1) {
                                            isDeclined = true;
                                            console.log("declined");
                                        }
                                        else {
                                            isDeclined = false;
                                        }
                                        console.log("before accepted button");
                                        console.log({ ...result._doc, isAccepted: isAccepted, isShortlisted: isShortlisted, isDeclined: isDeclined });
                                        return res.json({ ...result._doc, isAccepted: isAccepted, isShortlisted: isShortlisted, isDeclined: isDeclined });
                                        // if (result.shortlisted.filter(shortlistedJob => shortlistedJob.toString() === req.body.userId).length == 1) {
                                        //     isShortlisted = true;
                                        //     console.log("shortlisted");
                                        // }
                                        // else {
                                        //     isShortlisted = false;
                                        // }
                                        // console.log("after shortlisted");
                                        // console.log(req.body.userId);
                                        // console.log({ ...result._doc, isShortlisted: isShortlisted });
                                        // return res.json({ ...result._doc, isShortlisted: isShortlisted });
                                    })
                                });


                            })
                        })


                    })

                }
                else {
                    return res.status(401).json({ msg: "Already Shortlisted" });
                }
            })
        }
        else if (work == "Declined") {
            userModel.findById(req.body.userId).then(user => {
                if (user.declined.filter(declinedJob => declinedJob.toString() === jobPostId).length == 0) {
                    console.log("inside");
                    userModel.findByIdAndUpdate(req.body.userId, { $push: { declined: jobPostId } }, { new: true }, (error, result) => {
                        userModel.findByIdAndUpdate(req.body.userId, { $pull: { accepted: jobPostId, shortlisted: jobPostId, pending: jobPostId } }, { new: true }, (error, result) => {
                            console.log("inside push");

                            if (error) return res.status(401).json({ msg: error.message });
                            postModel.findByIdAndUpdate(jobPostId, { $push: { declined: req.body.userId } }, { new: true }, (err, results) => {
                                if (err) return res.status(401).json({ msg: err.message });
                                // res.json({ result, results });

                                postModel.findByIdAndUpdate(jobPostId, { $pull: { accepted: req.body.userId, shortlisted: req.body.userId } }, { new: true }, (err, results) => {
                                    console.log("before post model");
                                    postModel.findOne({ _id: jobPostId }).exec(function (error, result) {
                                        console.log('hehehe');
                                        console.log(result);
                                        if (error) return res.status(401).json({ msg: error.message });


                                        if (result.accepted.filter(acceptedJob => acceptedJob.toString() === req.body.userId).length == 1) {
                                            isAccepted = true;
                                            console.log("accepted");
                                        }
                                        else {
                                            isAccepted = false;
                                        }
                                        if (result.shortlisted.filter(shortJob => shortJob.toString() === req.body.userId).length == 1) {
                                            isShortlisted = true;
                                            console.log("shortlisted");
                                        }
                                        else {
                                            isShortlisted = false;
                                        }
                                        if (result.declined.filter(declineJob => declineJob.toString() === req.body.userId).length == 1) {
                                            isDeclined = true;
                                            console.log("declined");
                                        }
                                        else {
                                            isDeclined = false;
                                        }
                                        console.log("before accepted button");
                                        console.log({ ...result._doc, isAccepted: isAccepted, isShortlisted: isShortlisted, isDeclined: isDeclined });
                                        return res.json({ ...result._doc, isAccepted: isAccepted, isShortlisted: isShortlisted, isDeclined: isDeclined });
                                        // if (result.shortlisted.filter(shortlistedJob => shortlistedJob.toString() === req.body.userId).length == 1) {
                                        //     isShortlisted = true;
                                        //     console.log("shortlisted");
                                        // }
                                        // else {
                                        //     isShortlisted = false;
                                        // }
                                        // console.log("after shortlisted");
                                        // console.log(req.body.userId);
                                        // console.log({ ...result._doc, isShortlisted: isShortlisted });
                                        // return res.json({ ...result._doc, isShortlisted: isShortlisted });
                                    })
                                });


                            })
                        })


                    })

                }
                else {
                    return res.status(401).json({ msg: "Already Declined" });
                }
            })
        }


    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


userAuth.post("/api/studioAcceptJobData", sAuth, async (req, res) => {

    try {
        const jobPostId = req.body.jobPostId;
        const jobPost = postModel.findById(jobPostId);

        if (!jobPost) {
            return res.status(401).json({ msg: "No Job found" });
        }
        postModel.findOne({ _id: jobPostId }).exec(function (error, result) {
            console.log('hehehe');
            console.log(result);
            if (error) return res.status(401).json({ msg: error.message });

            if (result.accepted.filter(acceptedJob => acceptedJob.toString() === req.body.userId).length == 1) {
                isAccepted = true;
                console.log("accepted");
            }
            else {
                isAccepted = false;
            }
            if (result.shortlisted.filter(shortJob => shortJob.toString() === req.body.userId).length == 1) {
                isShortlisted = true;
                console.log("shortlisted");
            }
            else {
                isShortlisted = false;
            }
            if (result.declined.filter(declineJob => declineJob.toString() === req.body.userId).length == 1) {
                isDeclined = true;
                console.log("declined");
            }
            else {
                isDeclined = false;
            }
            console.log("before accepted button");
            console.log({ ...result._doc, isAccepted: isAccepted, isShortlisted: isShortlisted, isDeclined: isDeclined });
            return res.json({ ...result._doc, isAccepted: isAccepted, isShortlisted: isShortlisted, isDeclined: isDeclined });
        })

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


userAuth.get("/api/showWorkingJobs", auth, async (req, res) => {
    try {
        const working = req.query.working;
        userModel.findById(req.user).then(user => {
            userModel.findById(req.user).populate(working).exec(function (error, result) {
                // if (error) return res.status(401).json({ msg: error.message });

                console.log(result);
                res.json(result);
            })
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


userAuth.get("/api/studio/showWorkingJobs", sAuth, async (req, res) => {
    try {
        let newResult = [];
        const working = req.query.working;
        console.log(working);
        studioModel.findById(req.user).then(user => {
            postModel.find({ studio: req.user }).exec(function (error, result) {
                // if (error) return res.status(401).json({ msg: error.message });
                console.log("hey hey hey hey");
                console.log("hey hey hey hey");
                console.log("hey hey hey hey");
                console.log("hey hey hey hey");
                console.log("hey hey hey hey");
                result.forEach(element => {
                    if (working == "accepted") {
                        if (element.accepted.length > 0) {
                            console.log(element.accepted);
                            newResult.push(element);
                        }
                    }
                    else if (working == "shortlisted") {
                        if (element.shortlisted.length > 0) {
                            console.log(element.shortlisted);
                            newResult.push(element);
                        }
                    }
                    else if (working == "applied") {
                        if (element.applicants.length > 0) {
                            console.log(element.applicants);
                            newResult.push(element);
                        }
                    }

                });

                console.log(newResult.length);
                console.log(result.length);
                // console.log(result);
                res.json(newResult);
            })
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

userAuth.post("/api/studio/getArtistData", sAuth, async (req, res) => {
    try {
        console.log("get user data");
        const user = await userModel.findById(req.body.userID);
        if (!user) {
            return res.status(401).json({ msg: "No user found" });
        }
        console.log("ahahahahhahahah");
        console.log("ahahahahhahahah");
        console.log("ahahahahhahahah");
        console.log("ahahahahhahahah");
        console.log("ahahahahhahahah");
        console.log({ ...user._doc, token: "" });
        res.json({ ...user._doc, token: "" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});



// profilePic upload
userAuth.post("/api/upload/profilePic", auth, async (req, res) => {
    try {

        await userModel.findByIdAndUpdate(req.user, { $set: { profilePic: req.body.profilePicUrl } }).then(user => {
            userModel.findById(req.user).exec(function (error, result) {
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

// Media upload
userAuth.post("/api/upload/media", auth, async (req, res) => {
    try {

        if (req.body.mediaType == "photos") {
            await userModel.findByIdAndUpdate(req.user, { $push: { photos: req.body.media } }).then(user => {
                userModel.findById(req.user).exec(function (error, result) {
                    console.log({ ...result._doc, token: "" });
                    res.json({ ...result._doc, token: req.token });
                });
            })
        }

        else if (req.body.mediaType == "videos") {
            console.log("inside video");
            await userModel.findByIdAndUpdate(req.user, { $push: { videos: req.body.media } }).then(user => {
                userModel.findById(req.user).exec(function (error, result) {
                    console.log({ ...result._doc, token: "" });
                    res.json({ ...result._doc, token: req.token });
                });
            })
        }
        else if (req.body.mediaType == "thumbnail") {
            console.log("inside video");
            await userModel.findByIdAndUpdate(req.user, { $push: { thumbnailVideo: req.body.media } }).then(user => {
                userModel.findById(req.user).exec(function (error, result) {
                    console.log({ ...result._doc, token: "" });
                    res.json({ ...result._doc, token: req.token });
                });
            })
        }



    } catch (error) {
        res.status(501).json({ error: error.message });
    }
});


// Media delete
userAuth.post("/api/delete/media", auth, async (req, res) => {
    try {

        if (req.body.mediaType == "photos") {
            await userModel.findByIdAndUpdate(req.user, { $pull: { photos: req.body.media } }).then(user => {
                userModel.findById(req.user).exec(function (error, result) {
                    console.log({ ...result._doc, token: "" });
                    res.json({ ...result._doc, token: req.token });
                });
            })
        }



    } catch (error) {
        res.status(501).json({ error: error.message });
    }
});


module.exports = userAuth;
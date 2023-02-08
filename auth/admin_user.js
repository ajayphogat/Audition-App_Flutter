const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const userModel = require("../model/audition_user");
const auth = require("../middleware/token_validation");
const jwtKey = require("../constant/const_variable");
const adminJwtKey = require("../constant/const_admin");
const studioModel = require("../model/studio_user");
const postModel = require("../model/job_post");
const adminModel = require("../model/admin_user");
const aAuth = require("../middleware/token_admin_validation");
const studioAuth = require("./studio_user_auth");
const nodeMailer = require("nodemailer");

//cron job like node-cron
const cron = require("node-cron");
const managerModel = require("../model/manager_user");



const adminAuth = express.Router();

// scheduling a task to check the user's subscription plan
cron.schedule("0 0 0 * * *", () => {
    // console.log("here is my cron job");
    userModel.updateMany({}, { $inc: { daysLeft: -1 } }, (err) => {
        if (err) {
            console.log(`here is the error -> ${err}`);
        }
        else {
            userModel.find().then(user => {
                console.log(user);
            })
        }
    })

    studioModel.updateMany({}, { $inc: { daysLeft: -1 } }, (err) => {
        if (err) {
            console.log(`here is the error -> ${err}`);
        }
        else {
            studioModel.find().then(user => {
                console.log(user);
            })
        }
    })

});

adminAuth.post("/admin/api/signup", async (req, res) => {
    try {
        const { fullName, number, email, password } = req.body;
        const existingUser = await adminModel.findOne({ email: email });
        console.log(existingUser);
        if (existingUser) {
            return res.status(400).json({ msg: "User with same email already exist!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new adminModel({
            fullName,
            number,
            email,
            password: hashedPassword,
        });

        user = await user.save();

        const token = jwt.sign({ id: user._id }, adminJwtKey);
        res.json({ ...user._doc, token: token });
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: error.message });

    }
});

adminAuth.post("/admin/api/login", async (req, res) => {
    try {
        const { email, password } = req.body;
        const existingUser = await adminModel.findOne({ email: email });
        if (!existingUser) {
            return res.status(400).json({ msg: "User not found!" });
        }
        const isMatch = await bcryptjs.compare(password, existingUser.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Password!" });
        }
        const token = jwt.sign({ id: existingUser._id }, adminJwtKey);
        res.json({ token, ...existingUser._doc });
    } catch (error) {
        res.status(500).json({ error: error.message });

    }
});

adminAuth.post("/api/admin/forgotPassword", async (req, res) => {
    try {
        const { email } = req.body;
        const otp1 = Math.floor(100000 + Math.random() * 900000);
        console.log(`otp => ${otp1}`);
        console.log(email);
        const existingUser = await adminModel.findOne({ email: email });
        console.log(email);
        console.log(existingUser);

        if (existingUser) {
            const otp = Math.floor(100000 + Math.random() * 900000);
            await adminModel.findOneAndUpdate({ email: email }, { $set: { otpSaved: otp } });
            const transporter = nodeMailer.createTransport({
                service: "gmail",
                port: 587,
                auth: {
                    user: 'beverycoool@gmail.com',
                    pass: "ntds kidk kqth uffs",
                },
            });

            var mailOptions = {
                from: "beverycoool@gmail.com",
                to: email,
                subject: "Reset Password OTP",
                text: `To Reset Password use this OTP: ${otp}`
            };


            transporter.sendMail(mailOptions, (err, info) => {
                if (err) {
                    console.log(err);
                    res.status(400).json({ msg: err.message });
                }
                else {
                    console.log(`email send: ${info.response}`);
                    res.json({ msg: 'Email Sent!' });
                }
            })


        }
        else {
            res.status(400).json({ msg: "Email is not Registered" });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// verify otp 
adminAuth.post("/api/admin/verifyOTP", async (req, res) => {
    try {
        const { email, otp, password } = req.body;
        console.log(email);
        console.log(otp);
        console.log(password);
        const existingUser = await adminModel.findOne({ email: email });
        if (!existingUser) return res.status(400).json({ msg: "Email not Registered" });
        if (otp != existingUser.otpSaved) {
            res.status(400).json({ msg: "Wrong OTP" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        await adminModel.findOneAndUpdate({ email: email }, { $set: { password: hashedPassword } });

        res.json({ msg: "Password Changed" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminAuth.get("/admin/api/getReport", aAuth, async (req, res) => {
    try {
        studioModel.find({ reported: true }).exec((err, result) => {
            if (err) return res.status(400).json({ msg: err.message });
            console.log(result);
            userModel.find({ reported: true }).exec((errr, resultt) => {
                if (errr) return res.status(400).json({ msg: errr.message });
                console.log(resultt);
                res.json({ studio: result, audition: resultt });
            });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminAuth.get("/admin/api/getAllData", aAuth, async (req, res) => {
    try {
        const studioUsers = await studioModel.find();
        const auditionUsers = await userModel.find();

        const currentYear = new Date().toDateString().split(" ")[3];
        const currentDate = new Date().getTime();

        // Array of popular studios
        let popStudios = [];

        //those who's logged in status is true
        let sActiveUsers = 0;
        let aActiveUsers = 0;

        //those who's logged in status is false
        let sInactiveUsers = 0;
        let aInactiveUsers = 0;

        // those who have created their ids within 5 days from the current date
        let sNewUsers = 0;
        let aNewUsers = 0;

        // those who have logged out month is less than current month 
        let sLeftUsers = 0;
        let aLeftusers = 0;

        // those who have paid the subscription amount
        let sSubscribers = 0;
        let aSubscribers = 0;


        let janAudition = 0;
        let febAudition = 0;
        let marAudition = 0;
        let aprAudition = 0;
        let mayAudition = 0;
        let junAudition = 0;
        let julAudition = 0;
        let augAudition = 0;
        let sepAudition = 0;
        let octAudition = 0;
        let novAudition = 0;
        let decAudition = 0;

        let janStudio = 0;
        let febStudio = 0;
        let marStudio = 0;
        let aprStudio = 0;
        let mayStudio = 0;
        let junStudio = 0;
        let julStudio = 0;
        let augStudio = 0;
        let sepStudio = 0;
        let octStudio = 0;
        let novStudio = 0;
        let decStudio = 0;
        auditionUsers.map((user) => {
            const userYear = new Date(user.createdDate).toDateString().split(" ")[3];
            const userMonth = new Date(user.createdDate).toDateString().split(" ")[1];
            const userDate = new Date(user.createdDate).getTime();
            const userLoggedOutDate = new Date(user.loggedOutDate).getTime();

            const newUserDays = parseInt((currentDate - userDate) / (1000 * 3600 * 24))


            const newUserLeftDays = parseInt((currentDate - userLoggedOutDate) / (1000 * 3600 * 24));

            if (user.subscriptionPrice !== 0) {
                aSubscribers += 1;
            }



            if (user.status === true) {
                aActiveUsers += 1;
            } else if (user.status === false) {
                aInactiveUsers += 1;
                if (newUserLeftDays >= 31) {
                    aLeftusers += 1;
                }
            }

            if (newUserDays <= 5) {
                aNewUsers += 1;
            }
            if (currentYear === userYear) {
                if (userMonth === "Jan") {
                    janAudition += 1;
                } else if (userMonth === "Feb") {
                    febAudition += 1;

                } else if (userMonth === "Mar") {
                    marAudition += 1;

                } else if (userMonth === "Apr") {
                    aprAudition += 1;

                } else if (userMonth === "May") {
                    mayAudition += 1;

                } else if (userMonth === "Jun") {
                    junAudition += 1;

                } else if (userMonth === "Jul") {
                    julAudition += 1;

                } else if (userMonth === "Aug") {
                    augAudition += 1;

                } else if (userMonth === "Sep") {
                    sepAudition += 1;

                } else if (userMonth === "Oct") {
                    octAudition += 1;

                } else if (userMonth === "Nov") {
                    novAudition += 1;

                } else {
                    decAudition += 1;
                }

            }
        })
        studioUsers.map((user) => {
            const userYear = new Date(user.createdDate).toDateString().split(" ")[3];
            const userMonth = new Date(user.createdDate).toDateString().split(" ")[1];

            const userDate = new Date(user.createdDate).getTime();
            const userLoggedOutDate = new Date(user.loggedOutDate).getTime();

            const newUserDays = parseInt((currentDate - userDate) / (1000 * 3600 * 24))


            const newUserLeftDays = parseInt((currentDate - userLoggedOutDate) / (1000 * 3600 * 24));

            if (user.subscriptionPrice !== 0) {
                sSubscribers += 1;
            }

            if (user.status === true) {
                sActiveUsers += 1;
            } else if (user.status === false) {
                sInactiveUsers += 1;
                if (newUserLeftDays >= 31) {
                    sLeftusers += 1;
                }
            }

            if (newUserDays <= 5) {
                sNewUsers += 1;
            }



            if (currentYear === userYear) {
                if (userMonth === "Jan") {
                    janStudio += 1;
                } else if (userMonth === "Feb") {
                    febStudio += 1;

                } else if (userMonth === "Mar") {
                    marStudio += 1;

                } else if (userMonth === "Apr") {
                    aprStudio += 1;

                } else if (userMonth === "May") {
                    mayStudio += 1;

                } else if (userMonth === "Jun") {
                    junStudio += 1;

                } else if (userMonth === "Jul") {
                    julStudio += 1;

                } else if (userMonth === "Aug") {
                    augStudio += 1;

                } else if (userMonth === "Sep") {
                    sepStudio += 1;

                } else if (userMonth === "Oct") {
                    octStudio += 1;

                } else if (userMonth === "Nov") {
                    novStudio += 1;

                } else {
                    decStudio += 1;
                }

            }
        })

        const studioData = {
            studioGraph:
                { janStudio: janStudio, febStudio: febStudio, marStudio: marStudio, aprStudio: aprStudio, mayStudio: mayStudio, junStudio: junStudio, julStudio: julStudio, augStudio: augStudio, sepStudio: sepStudio, octStudio: octStudio, novStudio: novStudio, decStudio: decStudio }, sActiveUsers: sActiveUsers, sInactiveUsers: sInactiveUsers, sLeftUsers: sLeftUsers, sNewUsers: sNewUsers, sSubscribers: sSubscribers
        }

        const auditionData = {
            auditionGraph: {
                janAudition: janAudition, febAudition: febAudition, marAudition: marAudition, aprAudition: aprAudition, mayAudition: mayAudition, junAudition: junAudition, julAudition: julAudition, augAudition: augAudition, sepAudition: sepAudition, octAudition: octAudition, novAudition: novAudition, decAudition: decAudition
            }, aActiveUsers: aActiveUsers, aInactiveUsers: aInactiveUsers, aLeftusers: aLeftusers, aNewUsers: aNewUsers, aSubscribers: aSubscribers
        }

        studioModel.find({}).sort({ followers: -1 }).limit(10).exec((err, user) => {
            if (err) {
                console.log(`here is the error err`);
            }
            else {
                console.log("heyyy");
                popStudios = user;

                // console.log(popStudios);
                console.log(auditionData);
                console.log(studioData);
                console.log("hahahah");
                console.log(popStudios);
                res.json({ studioData: studioData, auditionData: auditionData, popStudios: popStudios, token: req.token });
            }
        })

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// Audition active users list
adminAuth.get("/admin/api/audition/getActive", aAuth, async (req, res) => {
    try {
        userModel.find({ status: true }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message });
            console.log(result);
            res.json(result);
        })
    } catch (error) {

        res.status(500).json({ error: error.message });
    }
});

// Audition Inactive users list
adminAuth.get("/admin/api/audition/getInactive", aAuth, async (req, res) => {
    try {
        userModel.find({ status: false }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message })
            console.log(result);
            res.json(result);
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Audition all Subscribers list
adminAuth.get("/admin/api/audition/getSubscribers", aAuth, async (req, res) => {
    try {
        userModel.find({}, (err, result) => {
            console.log(result);

            res.json(result);
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// Studio all Active users list
adminAuth.get("/admin/api/studio/getActive", aAuth, async (req, res) => {
    try {
        studioModel.find({ status: true }, (err, result) => {
            console.log(result);
            res.json(result);
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminAuth.get("/admin/api/studio/getInactive", aAuth, async (req, res) => {
    try {
        studioModel.find({ status: false }, (err, result) => {
            console.log(result);
            res.json(result);
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminAuth.get("/admin/api/studio/getSubscribers", aAuth, async (req, res) => {
    try {
        studioModel.find({}, (err, result) => {
            console.log(result);
            res.json(result);
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Edit audition Active users
adminAuth.post("/admin/api/audition/editActive", aAuth, async (req, res) => {
    try {

        const { userID, fname, subscription, location, bio, category } = req.body;
        let subscriptionPrice = 0;
        if (subscription === "Free") {
            subscriptionPrice = 0;
        }
        else if (subscription === "Gold") {
            subscriptionPrice = 500;
        }
        else {
            subscriptionPrice = 1000;
        }
        console.log({ userID, fname, subscription, location, bio, category });
        userModel.findByIdAndUpdate(userID, { $set: { fname: fname, subscriptionName: subscription, subscriptionPrice: subscriptionPrice, location: location, bio: bio, category: category } }, { new: true }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message });

            userModel.find({ status: true }, (err, result) => {
                if (err) return res.status(400).json({ msg: err.message });
                console.log(result);
                res.json(result);
            })

        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Edit audition Inactive users
adminAuth.post("/admin/api/audition/editInactive", aAuth, async (req, res) => {
    try {
        const { userID, fname, subscription, location, bio, category } = req.body;
        let subscriptionPrice = 0;
        if (subscription === "Free") {
            subscriptionPrice = 0;
        }
        else if (subscription === "Gold") {
            subscriptionPrice = 500;
        }
        else {
            subscriptionPrice = 1000;
        }
        console.log({ userID, fname, subscription, location, bio, category });
        userModel.findByIdAndUpdate(userID, { $set: { fname: fname, subscriptionName: subscription, subscriptionPrice: subscriptionPrice, location: location, bio: bio, category: category } }, { new: true }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message });

            userModel.find({ status: false }, (err, result) => {
                if (err) return res.status(400).json({ msg: err.message });
                console.log(result);
                res.json(result);
            })
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Edit audition Subscriber users
adminAuth.post("/admin/api/audition/editSubs", aAuth, async (req, res) => {
    try {
        const { userID, fname, subscription, subscriptionPrice, location, bio } = req.body;
        console.log(userID);
        userModel.findByIdAndUpdate(userID, { $set: { fname: fname, subscriptionName: subscription, subscriptionPrice: subscriptionPrice, location: location, bio: bio } }, { new: true }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message });

            res.json({ ...result._doc });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// Edit studio Active users
adminAuth.post("/admin/api/studio/editActive", aAuth, async (req, res) => {
    try {
        const { userID, studio, subscription, country, desc } = req.body;
        let subscriptionPrice = 0;
        if (subscription === "Free") {
            subscriptionPrice = 0;
        }
        else if (subscription === "Gold") {
            subscriptionPrice = 500;
        }
        else {
            subscriptionPrice = 1000;
        }
        console.log({ userID, studio, subscription, country, desc });
        studioModel.findByIdAndUpdate(userID, { $set: { fname: studio, subscriptionName: subscription, subscriptionPrice: subscriptionPrice, location: country, projectDesc: desc } }, { new: true }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message });

            studioModel.find({ status: true }, (err, result) => {
                console.log(result);
                res.json(result);
            });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Edit studio Inactive users
adminAuth.post("/admin/api/studio/editInactive", aAuth, async (req, res) => {
    try {
        const { userID, studio, subscription, country, desc } = req.body;
        let subscriptionPrice = 0;
        if (subscription === "Free") {
            subscriptionPrice = 0;
        }
        else if (subscription === "Gold") {
            subscriptionPrice = 500;
        }
        else {
            subscriptionPrice = 1000;
        }
        console.log({ userID, studio, subscription, country, desc });
        studioModel.findByIdAndUpdate(userID, { $set: { fname: studio, subscriptionName: subscription, subscriptionPrice: subscriptionPrice, location: country, projectDesc: desc } }, { new: true }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message });

            studioModel.find({ status: false }, (err, result) => {
                console.log(result);
                res.json(result);
            });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Edit studio Subscriber users
adminAuth.post("/admin/api/studio/editSubs", aAuth, async (req, res) => {
    try {
        const { userID, studio, subscription, subscriptionPrice, country, desc } = req.body;
        console.log(userID);
        studioModel.findByIdAndUpdate(userID, { $set: { fname: studio, subscriptionName: subscription, subscriptionPrice: subscriptionPrice, location: country, aboutDesc: desc } }, { new: true }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message });

            res.json({ ...result._doc });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Get all Promotion Request
adminAuth.get("/admin/api/studio/getPromotionRequest", aAuth, async (req, res) => {
    try {
        adminModel.findById(req.user).populate("promotionRequest").exec((err, result) => {
            if (err) return res.status(401).json({ msg: err.message });

            console.log(result.promotionRequest);
            res.json(result.promotionRequest);
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// Accept Promotion Request 
adminAuth.post("/admin/api/studio/acceptPromotionReq", aAuth, async (req, res) => {
    try {
        const { jobId } = req.body;
        console.log(jobId);
        postModel.findByIdAndUpdate(jobId, { $set: { promoted: true } }, { new: true }, (err, result) => {
            if (err) return res.status(400).json({ msg: err.message });

            adminModel.findById(req.user).populate("promotionRequest").exec((err, resultss) => {
                if (err) return res.status(400).json({ msg: err.message });
                res.json({ ...resultss._doc });
            });
        })
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminAuth.post("/admin/api/delete", aAuth, async (req, res) => {
    try {
        const { userID, user } = req.body;

        if (user === "audition") {
            userModel.deleteOne({ _id: userID }).then((result) => {
                userModel.find().then((result) => {
                    console.log(result);
                    res.json(result);
                });
            }).catch((error) => {
                res.status(500).json({ error: error.message });
            })
        }
        else {

            postModel.deleteMany({ studio: userID }).then((result) => {
                studioModel.deleteOne({ _id: userID }).then((result) => {
                    userModel.find().then((result) => {
                        console.log(result);
                        res.json(result);
                    });
                }).catch((error) => {
                    res.status(500).json({ error: error.message });
                })
            }).catch((error) => {
                res.status(500).json({ error: error.message });
            });
        }

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// get all managers 
adminAuth.get("/api/admin/getAllManagers", aAuth, async (req, res) => {
    try {
        const existingUser = await adminModel.findById(req.user);
        if (!existingUser) return res.status(400).json({ msg: "User not found" });
        managerModel.find().populate("studio").exec((err, result) => {
            if (err) return res.status(400).json({ msg: err.message });
            console.log(result);
            res.json(result);
        })

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// delete Manager
adminAuth.post("/api/admin/deleteManager", aAuth, async (req, res) => {
    try {
        const { studioId, managerId } = req.body;
        const existingUser = await adminModel.findById(req.user);
        if (!existingUser) return res.status(400).json({ msg: "User not found" });
        managerModel.deleteOne({ _id: managerId }).then((result) => {
            studioModel.updateOne({ _id: studioId }, { $pull: { manager: managerId } }, { new: true }, (error, result) => {
                if (error) return res.status(400).json({ error: error.message });
                managerModel.find().then((result) => {
                    console.log(result);
                    res.json(result);
                });
            });
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})



module.exports = adminAuth;
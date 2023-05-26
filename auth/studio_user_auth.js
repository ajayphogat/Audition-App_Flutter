const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const studioModel = require("../model/studio_user");
const jwtKey = require("../constant/const_studio");
const sAuth = require("../middleware/token_studio_validation");
const userModel = require("../model/audition_user");
const managerAuth = require("./manager_user_auth");
const managerModel = require("../model/manager_user");
const nodeMailer = require("nodemailer");
// / twilio configuration->
const accountSid = "AC2bfb3a2209314707d7d54c3dc7ff0fa1";
const authToken = "ba8b3ef7b22a30d99bd944f4c55335b4";
const client = require("twilio")(accountSid, authToken);
const studioAuth = express.Router();
const optModel = require("../model/otp");
// Studio - Signup api
studioAuth.post("/api/studio/signup", async (req, res) => {
  try {
    let firebaseCreate;
    const { fname, number, email, password } = req.body;
    const existingUser = await studioModel.findOne({
      $and: [{ email: email }, { number: number }],
    });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email or number already exist!" });
    }
    const existingAudition = await userModel.findOne({ email });
    if (existingAudition) {
      firebaseCreate = false;
    } else {
      firebaseCreate = true;
    }
    const hashedPassword = await bcryptjs.hash(password, 8);

    // send otp ->

    // Generate a 6-digit OTP
    const otp = Math.floor(1000 + Math.random() * 9000);

    await client.messages.create({
      body: `Your OTP is: ${otp}`,
      from: "+13158175295",
      to: `+91${number}`,
    });

    await optModel.create({
      phoneNumber: number,
      otp: otp,
    });

    // create new user
    let user = new studioModel({
      fname,
      number,
      email,
      password: hashedPassword,
    });

    user = await user.save();
    res.json({ ...user._doc, created: firebaseCreate, number, otp });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// verify  otp-> studio

studioAuth.post("/api/studio/verify-otp", async (req, res) => {
  try {
    
    const { number, otp } = req.body;
    const result = await optModel.findOne({ phoneNumber: number });
    if (!result) {
    return  res.status(400).json({ msg: "Number not found" });
    }
    console.log(result.otp);
    console.log(otp,'entered');
    if (result.otp === Number(otp)) {
      console.log('otp matched and deleted');
     await optModel.findByIdAndDelete(result._id);
     
     return res.json({ msg: "OTP verified successfully" });
    } else {
    return  res.status(400).json({ error: "OTP does not match" });
    }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Studio login api
studioAuth.post("/api/studio/login", async (req, res) => {
  try {
    console.log(req.body.email);
    const { email, password } = req.body;
    const existingUser = await studioModel.findOne({ email });
    if (!existingUser) {
      return res.status(400).json({ msg: "User not found!" });
    }
    const isMatch = await bcryptjs.compare(password, existingUser.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect Password!" });
    }

    studioModel.findByIdAndUpdate(
      existingUser._id,
      { $set: { loggedInDate: new Date().toISOString(), status: true } },
      { new: true },
      (err, result) => {
        if (err) return res.status(401).json({ msg: err.message });

        const token = jwt.sign({ id: result._id }, jwtKey);
        return res.json({ token, ...result._doc });
      }
    );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Studio help and support
studioAuth.post("/api/studio/help", async (req, res) => {
  try {
    const { fullName, number, email, message } = req.body;

    const transporter = nodeMailer.createTransport({
      service: "gmail",
      port: 587,
      auth: {
        user: "beverycoool@gmail.com",
        pass: "ntds kidk kqth uffs",
      },
    });

    var mailOptions = {
      from: "beverycoool@gmail.com",
      to: email,
      subject: "Help & Support",
      text: `
            Name: ${fullName}
            Number: ${number}
            Message: ${message}
            `,
    };

    transporter.sendMail(mailOptions, (err, info) => {
      if (err) {
        console.log(err);
        res.status(400).json({ msg: err.message });
      } else {
        console.log(`email send: ${info.response}`);
        res.json({ msg: "Email Sent!" });
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// forrget password
studioAuth.post("/api/studio/forgotPassword", async (req, res) => {
  try {
    const { number } = req.body;
    const otp = Math.floor(1000 + Math.random() * 9000);
    console.log(`otp => ${otp}`);
    // console.log(email);
    const existingUser = await studioModel.findOne({ number: number });
    // console.log(email);
    // console.log(existingUser);

    // if (existingUser) {
    //   const otp = Math.floor(100000 + Math.random() * 900000);
    //   await studioModel.findOneAndUpdate(
    //     { email: email },
    //     { $set: { otpSaved: otp } }
    //   );
    //   const transporter = nodeMailer.createTransport({
    //     service: "gmail",
    //     port: 587,
    //     auth: {
    //       user: "beverycoool@gmail.com",
    //       pass: "ntds kidk kqth uffs",
    //     },
    //   });

    //   var mailOptions = {
    //     from: "beverycoool@gmail.com",
    //     to: email,
    //     subject: "Reset Password OTP",
    //     text: `To Reset Password use this OTP: ${otp}`,
    //   };

    //   transporter.sendMail(mailOptions, (err, info) => {
    //     if (err) {
    //       console.log(err);
    //       res.status(400).json({ msg: err.message });
    //     } else {
    //       console.log(`email send: ${info.response}`);
    //       res.json({ msg: "Email Sent!" });
    //     }
    //   });
    // } else {
    //   res.status(400).json({ msg: "Email is not Registered" });
    // }
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//  send otp for forget password->

studioAuth.post("/api/send/otp/forget/password", async (req, res) => {
  try {
    const { number } = req.body;
    const user = await studioModel.findOne({ number: number });
    console.log(user);
    if (!user) {
      return res.json({ msg: "user not found" });
    }
    // Generate a 6-digit OTP
    const otp = Math.floor(100000 + Math.random() * 900000);

    // send
    await client.messages.create({
      body: `Your OTP is: ${otp}`,
      from: "+13158175295",
      to: `+91${number}`,
    });
    //  save to db
    await optModel.create({
      phoneNumber: number,
      otp: otp,
    });
    res.json({ msg: "opt sent ", number, otp });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// now change the password after otp verification->

studioAuth.post("/reset/password/studio", async (req, res) => {
  try {
    const { number, password } = req.body;
    const studio = await studioModel.findOne({ number: number });
    if (!studio) {
      return res.status(400).json({ msg: "user not found" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);
    await studioModel.findOneAndUpdate(
      { number: number },
      { $set: { password: hashedPassword } }
    );
    res.json({msg:'Password changed'});
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// verify otp
studioAuth.post("/api/studio/verifyOTP", async (req, res) => {
  try {
    const { email, otp, password } = req.body;
    console.log(email);
    console.log(otp);
    console.log(password);
    const existingUser = await studioModel.findOne({ email: email });
    console.log("a");
    if (!existingUser)
      return res.status(400).json({ msg: "Email not Registered" });
    console.log("b");
    if (otp != existingUser.otpSaved) {
      return res.status(400).json({ msg: "Wrong OTP" });
    }
    console.log("c");
    const hashedPassword = await bcryptjs.hash(password, 8);
    studioModel
      .findOneAndUpdate(
        { email: email },
        { $set: { password: hashedPassword } }
      )
      .then((result) => {
        console.log("d");
        res.json({ msg: "Password Changed" });
      });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Studio logout api
studioAuth.post("/api/studio/logout", sAuth, async (req, res) => {
  try {
    studioModel.findByIdAndUpdate(
      req.user,
      { $set: { loggedOutDate: new Date().toISOString(), status: false } },
      { new: true },
      (err, result) => {
        if (err) return res.status(400).json({ msg: err.message });
        console.log(result);
        return res.json({ ...result._doc });
      }
    );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Studio subscription update api
studioAuth.get("/api/studio/subscriptionData", sAuth, async (req, res) => {
  try {
    const { subscriptionName, subscriptionPrice } = req.body;
    const existingUser = await studioModel.findById(req.user);
    if (!existingUser) return res.status(400).json({ msg: "User not found!" });
    studioModel.findByIdAndUpdate(
      req.user,
      { $set: { subscriptionName, subscriptionPrice } },
      { new: true },
      (err, result) => {
        if (err) return res.status(400).json({ msg: err.message });
        res.json(result);
      }
    );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// report studio api
studioAuth.post("/api/studio/report", sAuth, async (req, res) => {
  try {
    studioModel.findByIdAndUpdate(
      req.user,
      { $set: { reported: true } },
      { new: true },
      (err, result) => {
        studioModel.find({ reported: true }).exec((err, result) => {
          if (err) return res.status(400).json({ msg: err.message });
          res.json({ ...result._doc });
        });
      }
    );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// get all Managers List
studioAuth.get("/api/studio/getAllManagers", sAuth, async (req, res) => {
  try {
    studioModel
      .findById(req.user)
      .populate("manager")
      .exec((err, result) => {
        console.log({ ...result._doc });
        res.json({ ...result._doc });
      });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// manager delete api
studioAuth.post("/api/studio/deleteManager", sAuth, async (req, res) => {
  try {
    const { userId } = req.body;
    managerModel.deleteOne({ _id: userId }).then((result) => {
      studioModel.updateOne(
        { _id: req.user },
        { $pull: { manager: userId } },
        { new: true },
        (error, result) => {
          if (error) return res.status(400).json({ error: error.message });
          studioModel
            .findById(req.user)
            .populate("manager")
            .exec((err, result) => {
              if (err) return res.status(400).json({ err: err.message });
              console.log({ ...result._doc });
              res.json({ ...result._doc });
            });
        }
      );
    });
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
    const updateNameLoc = await studioModel.updateOne(
      { _id: req.user },
      { $set: { fname: fname, location: location } }
    );
    if (updateNameLoc.acknowledged == false) {
      return res.status(400).json({ msg: "Can't save! Try Again" });
    }
    user = await studioModel.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

studioAuth.post("/api/studio/profileURL", sAuth, async (req, res) => {
  try {
    const { profileUrl } = req.body;
    let user = await studioModel.findById(req.user);
    if (!user) {
      return res.status(400).json({ msg: "No user found" });
    }
    const updateUrl = await studioModel.updateOne(
      { _id: req.user },
      { $set: { profileUrl: profileUrl } }
    );
    if (updateUrl.acknowledged == false) {
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
    const updateProjectDesc = await studioModel.updateOne(
      { _id: req.user },
      { $set: { projectDesc: projectDesc } }
    );
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
    const updateAboutDesc = await studioModel.updateOne(
      { _id: req.user },
      { $set: { aboutDesc: aboutDesc } }
    );
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

    studioModel
      .findById(req.user)
      .then((user) => {
        studioModel
          .findById(req.user)
          .populate("post")
          .exec(function (error, result) {
            if (result.post.length !== 0) {
              for (let index = 0; index < result.post.length; index++) {
                totalApplicants =
                  totalApplicants + result.post[index].applicants.length;
              }
              for (let index = 0; index < result.post.length; index++) {
                totalShortlisted =
                  totalShortlisted + result.post[index].shortlisted.length;
              }
              for (let index = 0; index < result.post.length; index++) {
                totalAccepted =
                  totalAccepted + result.post[index].accepted.length;
              }
              for (let index = 0; index < result.post.length; index++) {
                totalDeclined =
                  totalDeclined + result.post[index].declined.length;
              }
              for (let index = 0; index < result.post.length; index++) {
                totalBookmark =
                  totalBookmark + result.post[index].bookmark.length;
              }
              console.log("start");
              let newMonth = result.post[0].date
                .toISOString()
                .split("T")[0]
                .split("-")[1];
              let newDay = result.post[0].date
                .toISOString()
                .split("T")[0]
                .split("-")[2];
              let newYear = result.post[0].date
                .toISOString()
                .split("T")[0]
                .split("-")[0];
              let pYear = new Date().toISOString().split("T")[0].split("-")[0];

              console.log(newMonth);
              console.log(newDay);
              console.log(newYear);
              console.log(pYear);

              for (let index = 0; index < result.post.length; index++) {
                const element = result.post[index];
                if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 1 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  janJob += 1;
                  janApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 2 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  febJob += 1;
                  febApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 3 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  marJob += 1;
                  marApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 4 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  aprJob += 1;
                  aprApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 5 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  mayJob += 1;
                  mayApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 6 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  junJob += 1;
                  junApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 7 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  julJob += 1;
                  julApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 8 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  augJob += 1;
                  augApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] == 9 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  sepJob += 1;
                  sepApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] ==
                    10 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  octJob += 1;
                  octApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] ==
                    11 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  novJob += 1;
                  novApplicants += element.applicants.length;
                } else if (
                  element.date.toISOString().split("T")[0].split("-")[1] ==
                    12 &&
                  element.date.toISOString().split("T")[0].split("-")[0] ==
                    pYear
                ) {
                  decJob += 1;
                  decApplicants += element.applicants.length;
                }
              }
            }

            console.log(decJob);
            console.log(decApplicants);
            // console.log(d.getUTCMonth() + 1);
            console.log("result date");
            console.log({
              janJob: janJob,
              febJob: febJob,
              marJob: marJob,
              aprJob: aprJob,
              mayJob: mayJob,
              junJob: junJob,
              julJob: julJob,
              augJob: augJob,
              sepJob: sepJob,
              octJob: octJob,
              novJob: novJob,
              decJob: decJob,
              janApplicants: janApplicants,
              febApplicants: febApplicants,
              marApplicants: marApplicants,
              aprApplicants: aprApplicants,
              mayApplicants: mayApplicants,
              junApplicants: junApplicants,
              julApplicants: julApplicants,
              augApplicants: augApplicants,
              sepApplicants: sepApplicants,
              octApplicants: octApplicants,
              novApplicants: novApplicants,
              decApplicants: decApplicants,
            });
            // console.log({ ...result._doc, token: req.token, totalAccepted: totalAccepted, totalApplicants: totalApplicants, totalBookmark: totalBookmark, totalShortlisted: totalShortlisted });
            // let shortt = ({ ...result._doc.post[0]._doc.applicants });
            // console.log(shortt);
            // console.log(result.post[0].studioName);
            // console.log({ ...result._doc.post[0]._doc.shortlisted })
            // console.log({ ...result._doc, token: req.token });
            res.json({
              ...result._doc,
              token: req.token,
              totalAccepted: totalAccepted.toString(),
              totalApplicants: totalApplicants.toString(),
              totalBookmark: totalBookmark.toString(),
              totalShortlisted: totalShortlisted.toString(),
              janJob: janJob,
              febJob: febJob,
              marJob: marJob,
              aprJob: aprJob,
              mayJob: mayJob,
              junJob: junJob,
              julJob: julJob,
              augJob: augJob,
              sepJob: sepJob,
              octJob: octJob,
              novJob: novJob,
              decJob: decJob,
              janApplicants: janApplicants,
              febApplicants: febApplicants,
              marApplicants: marApplicants,
              aprApplicants: aprApplicants,
              mayApplicants: mayApplicants,
              junApplicants: junApplicants,
              julApplicants: julApplicants,
              augApplicants: augApplicants,
              sepApplicants: sepApplicants,
              octApplicants: octApplicants,
              novApplicants: novApplicants,
              decApplicants: decApplicants,
            });
          });
      })
      .catch((err) => {
        res.status(501).json({ error: err.message });
      });
  } catch (error) {}
});

// profilePic upload
studioAuth.post("/api/upload/studio/profilePic", sAuth, async (req, res) => {
  try {
    console.log(req.body.profilePicUrl);
    console.log("Studio");

    await studioModel
      .findByIdAndUpdate(req.user, {
        $set: { profilePic: req.body.profilePicUrl },
      })
      .then((user) => {
        studioModel.findById(req.user).exec(function (error, result) {
          console.log({ ...result._doc, token: "" });
          res.json({ ...result._doc, token: req.token });
        });
      });

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
    studioModel.findById(req.user).then((user) => {
      studioModel
        .findById(req.user)
        .populate("followers")
        .exec(function (error, result) {
          if (error) return res.status(401).json({ msg: error.message });

          console.log(result);
          res.json(result);
        });
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = studioAuth;

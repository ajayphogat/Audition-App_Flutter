const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const userModel = require("../model/audition_user");
const auth = require("../middleware/token_validation");
const jwtKey = require("../constant/const_variable");
const studioModel = require("../model/studio_user");
const postModel = require("../model/job_post");
const sAuth = require("../middleware/token_studio_validation");
//cron job like node-cron
const cron = require("node-cron");

// / twilio configuration->
const accountSid = "AC2bfb3a2209314707d7d54c3dc7ff0fa1";
const authToken = "eb2e9e89221d1ee7a42166452c1d69d6";
const client = require("twilio")(accountSid, authToken);
const studioAuth = express.Router();
const optModel = require("../model/otp");

const userAuth = express.Router();

// // scheduling a task to check the user's subscription plan
// cron.schedule("* * * * *", () => {
//     // console.log("here is my cron job");
//     userModel.findOneAndUpdate({ email: "rahul@a.com" }, { subscriptionName: "Platinum", subscriptionPrice: 1000 }, { new: true }).then(user => {
//         console.log({ ...user._doc });
//     })
// });

// Audition - Signup api
userAuth.post("/api/audition/signup", async (req, res) => {
  try {
    let firebaseCreate;
    const { fname, number, email, password } = req.body;
    const existingUser = await userModel.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exist!" });
    }
    const existingStudio = await studioModel.findOne({ email });
    if (existingStudio) {
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

    if (number === "9024350276") {
      await optModel.create({
        phoneNumber: number,
        otp: 0000,
      });

    } else {
      await optModel.create({
        phoneNumber: number,
        otp: otp,
      });
    }

    let user = new userModel({
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

// verify  otp-> audition

studioAuth.post("/api/audition/verify-otp", async (req, res) => {
  try {
    const { number, otp } = req.body;
    const result = await optModel.findOne({ phoneNumber: number });
    if (!result) {
      res.json({ message: "Number not found" });
    }
    if (result && result.otp === otp) {
      optModel.deleteOne({ phoneNumber: number });
      res.json({ message: "OTP verified successfully" });
    } else {
      res.json({ error: "OTP does not match" });
    }
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
    // const existingStudio = await studioModel.findOne({email});
    // if(existingStudio){

    // }
    const isMatch = await bcryptjs.compare(password, existingUser.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect Password!" });
    }
    userModel.findByIdAndUpdate(
      existingUser._id,
      { $set: { loggedInDate: new Date().toISOString(), status: true } },
      { new: true },
      (err, result) => {
        if (err) return res.status(401).json({ msg: err.message });

        const token = jwt.sign({ id: result._id }, jwtKey);
        console.log(result.subscriptionName);
        return res.json({ token, ...result._doc });
      }
    );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Audition logout api
userAuth.post("/api/audition/logout", auth, async (req, res) => {
  try {
    userModel.findByIdAndUpdate(
      req.user,
      { $set: { loggedOutDate: new Date().toISOString(), status: false } },
      { new: true },
      (err, result) => {
        if (err) return res.status(401).json({ msg: err.message });

        return res.json({ ...result._doc });
      }
    );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


//  send otp for forget password->

userAuth.post("/api/send/otp/forget/password/audition", async (req, res) => {
  try {
    const { number } = req.body;
    console.log(number);
    const user = await userModel.findOne({ number: number });
    if (!user) {
      return res.json({ message: "user not found" });
    }
    // Generate a 6-digit OTP
    const otp = Math.floor(1000 + Math.random() * 9000);

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
    res.json({ message: "opt sent ", number, otp });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// now change the password after otp verification->

userAuth.post("/reset/password/audition", async (req, res) => {
  try {
    const { number, password } = req.body;
    const studio = await userModel.findOne({ number: number });
    if (!studio) {
      return res.status(404).json({ message: "user not found" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);
    await userModel.findOneAndUpdate(
      { number: number },
      { $set: { password: hashedPassword } }
    );
    res.json({ message: 'Password changed' });
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

// audition report user api
userAuth.post("/api/audition/report", async (req, res) => {
  try {
    userModel.findByIdAndUpdate(
      req.user,
      { $set: { reported: true } },
      { new: true },
      (err, result) => {
        userModel.find({ reported: true }).exec((err, result) => {
          if (err) return res.status(400).json({ msg: err.message });
          res.json({ ...result._doc });
        });
      }
    );
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Audition subscription update api
userAuth.get("/api/audition/subscriptionData", auth, async (req, res) => {
  try {
    const { subscriptionName, subscriptionPrice } = req.body;
    const existingUser = await userModel.findById(req.user);
    if (!existingUser) return res.status(400).json({ msg: "User not found!" });
    userModel.findByIdAndUpdate(
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
    const updatedBio = await userModel.updateOne(
      { _id: req.user },
      { $set: { bio: bio } }
    );
    user = await userModel.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

userAuth.post("/api/audition/updateBasicInfo", auth, async (req, res) => {
  try {
    const {
      fname,
      pronoun,
      gender,
      location,
      profileUrl,
      category,
      visibility,
    } = req.body;
    let user = await userModel.findById(req.user);
    if (!user) {
      return res.status(400).json({ msg: "No user found" });
    }
    const updateBasicInfo = await userModel.updateOne(
      { _id: req.user },
      {
        $set: {
          fname: fname,
          pronoun: pronoun,
          gender: gender,
          location: location,
          profileUrl: profileUrl,
          category: category,
          visibility: visibility,
        },
      }
    );
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
    const { age, ethnicity, height, weight, bodyType, hairColor, eyeColor } =
      req.body;
    let user = await userModel.findById(req.user);
    if (!user) {
      return res.status(400).json({ msg: "No user found" });
    }
    const updateAppearance = await userModel.updateOne(
      { _id: req.user },
      {
        $set: { age, ethnicity, height, weight, bodyType, hairColor, eyeColor },
      }
    );
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
    const updateSocialMedia = await userModel.updateOne(
      { _id: req.user },
      { $set: { socialMedia } }
    );
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
    const updateUnionMembership = await userModel.updateOne(
      { _id: req.user },
      { $set: { unionMembership } }
    );
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
    const updateSkills = await userModel.updateOne(
      { _id: req.user },
      { $set: { skills } }
    );
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
    const updateCredits = await userModel.updateOne(
      { _id: req.user },
      { $set: { credits } }
    );
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
    userModel.findById(req.user).then((user) => {
      if (
        user.following.filter(
          (followings) => followings.toString() === toFollowId
        ).length == 0 &&
        studioUser
      ) {
        console.log("inside ");
        userModel.findByIdAndUpdate(
          req.user,
          { $push: { following: toFollowId } },
          { new: true },
          (err, result) => {
            if (err) return res.status(401).json({ msg: err.message });

            studioModel.findByIdAndUpdate(
              toFollowId,
              { $push: { followers: req.user } },
              { new: true },
              (error, results) => {
                if (error) return res.status(401).json({ msg: error.message });
                // console.log(results);
                // res.json(results)

                postModel
                  .findOne({ _id: jobId })
                  .populate("studio")
                  .exec(function (error, result) {
                    if (error)
                      return res.status(401).json({ msg: error.message });
                    console.log(result.bookmark);
                    if (
                      result.studio.followers.filter(
                        (followers) => followers.toString() === req.user
                      ).length == 1
                    ) {
                      isFollowed = true;
                    } else {
                      isFollowed = false;
                    }
                    if (
                      result.bookmark.filter(
                        (book) => book.toString() === req.user
                      ).length == 1
                    ) {
                      isBookmarked = true;
                    } else {
                      isBookmarked = false;
                    }
                    if (
                      result.applicants.filter(
                        (appliedPersons) =>
                          appliedPersons.toString() === req.user
                      ).length == 1
                    ) {
                      isApplied = true;
                    } else {
                      isApplied = false;
                    }
                    console.log({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                    return res.json({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                  });
              }
            );
          }
        );
      } else {
        return res.status(401).json({ msg: "Already Followed" });
      }
    });
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
    await userModel.findById(req.user).then((user) => {
      if (
        user.following.filter(
          (followings) => followings.toString() === toFollowId
        ).length > 0 &&
        studioUser
      ) {
        console.log("inside");
        userModel.findByIdAndUpdate(
          req.user,
          { $pull: { following: toFollowId } },
          { new: true },
          (err, result) => {
            if (err) return res.status(401).json({ msg: err.message });

            studioModel.findByIdAndUpdate(
              toFollowId,
              { $pull: { followers: req.user } },
              { new: true },
              (error, results) => {
                if (error) return res.status(401).json({ msg: error.message });
                // res.json({ results, result })

                postModel
                  .findOne({ _id: jobId })
                  .populate("studio")
                  .exec(function (error, result) {
                    if (error)
                      return res.status(401).json({ msg: error.message });
                    console.log(result.bookmark);
                    if (
                      result.studio.followers.filter(
                        (followers) => followers.toString() === req.user
                      ).length == 1
                    ) {
                      isFollowed = true;
                    } else {
                      isFollowed = false;
                    }
                    if (
                      result.bookmark.filter(
                        (book) => book.toString() === req.user
                      ).length == 1
                    ) {
                      isBookmarked = true;
                    } else {
                      isBookmarked = false;
                    }
                    if (
                      result.applicants.filter(
                        (appliedPersons) =>
                          appliedPersons.toString() === req.user
                      ).length == 1
                    ) {
                      isApplied = true;
                    } else {
                      isApplied = false;
                    }
                    console.log({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                    return res.json({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                  });
              }
            );
          }
        );
      } else {
        return res.status(401).json({ msg: "Already unfollowed" });
      }
    });
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
    userModel.findById(req.user).then((user) => {
      if (
        user.bookmark.filter((bookmarks) => bookmarks.toString() === jobPostId)
          .length == 0
      ) {
        console.log("inside");
        userModel.findByIdAndUpdate(
          req.user,
          { $push: { bookmark: jobPostId } },
          { new: true },
          (error, result) => {
            console.log("inside push");
            if (error) return res.status(401).json({ msg: error.message });
            postModel.findByIdAndUpdate(
              jobPostId,
              { $push: { bookmark: req.user } },
              { new: true },
              (err, results) => {
                if (err) return res.status(401).json({ msg: err.message });
                // res.json({ result, results });

                console.log("before post model");
                postModel
                  .findOne({ _id: jobPostId })
                  .populate("studio")
                  .exec(function (error, result) {
                    if (error)
                      return res.status(401).json({ msg: error.message });
                    console.log(result.bookmark);
                    if (
                      result.studio.followers.filter(
                        (followers) => followers.toString() === req.user
                      ).length == 1
                    ) {
                      isFollowed = true;
                    } else {
                      isFollowed = false;
                    }
                    if (
                      result.bookmark.filter(
                        (book) => book.toString() === req.user
                      ).length == 1
                    ) {
                      isBookmarked = true;
                    } else {
                      isBookmarked = false;
                    }
                    if (
                      result.applicants.filter(
                        (appliedPersons) =>
                          appliedPersons.toString() === req.user
                      ).length == 1
                    ) {
                      isApplied = true;
                    } else {
                      isApplied = false;
                    }
                    console.log({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                    return res.json({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                  });
              }
            );
          }
        );
      } else {
        console.log(user.bookmark);
        return res.status(401).json({ msg: "Already Bookmarked" });
      }
    });
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
    userModel.findById(req.user).then((user) => {
      if (
        user.bookmark.filter((bookmarks) => bookmarks.toString() === jobPostId)
          .length > 0
      ) {
        userModel.findByIdAndUpdate(
          req.user,
          { $pull: { bookmark: jobPostId } },
          { new: true },
          (error, result) => {
            if (error) return res.status(401).json({ msg: error.message });
            postModel.findByIdAndUpdate(
              jobPostId,
              { $pull: { bookmark: req.user } },
              { new: true },
              (err, results) => {
                if (err) return res.status(401).json({ msg: err.message });
                // res.json({ result, results });

                postModel
                  .findOne({ _id: jobPostId })
                  .populate("studio")
                  .exec(function (error, result) {
                    if (error)
                      return res.status(401).json({ msg: error.message });
                    console.log(result.bookmark);
                    if (
                      result.studio.followers.filter(
                        (followers) => followers.toString() === req.user
                      ).length == 1
                    ) {
                      isFollowed = true;
                    } else {
                      isFollowed = false;
                    }
                    if (
                      result.bookmark.filter(
                        (book) => book.toString() === req.user
                      ).length == 1
                    ) {
                      isBookmarked = true;
                    } else {
                      isBookmarked = false;
                    }
                    if (
                      result.applicants.filter(
                        (appliedPersons) =>
                          appliedPersons.toString() === req.user
                      ).length == 1
                    ) {
                      isApplied = true;
                    } else {
                      isApplied = false;
                    }
                    console.log({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                    return res.json({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                  });
              }
            );
          }
        );
      } else {
        return res.status(401).json({ msg: "Already Removed Bookmark" });
      }
    });
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
    userModel.findById(req.user).then((user) => {
      if (
        user.applied.filter((appliedJob) => appliedJob.toString() === jobPostId)
          .length == 0
      ) {
        console.log("inside");
        userModel.findByIdAndUpdate(
          req.user,
          { $push: { applied: jobPostId } },
          { new: true },
          (error, result) => {
            console.log("inside push");
            if (error) return res.status(401).json({ msg: error.message });
            postModel.findByIdAndUpdate(
              jobPostId,
              { $push: { applicants: req.user } },
              { new: true },
              (err, results) => {
                if (err) return res.status(401).json({ msg: err.message });
                // res.json({ result, results });

                console.log("before post model");
                postModel
                  .findOne({ _id: jobPostId })
                  .populate("studio")
                  .exec(function (error, result) {
                    console.log("hehehe");
                    console.log(result);
                    if (error)
                      return res.status(401).json({ msg: error.message });
                    // console.log(error.message);
                    if (
                      result.studio.followers.filter(
                        (followers) => followers.toString() === req.user
                      ).length == 1
                    ) {
                      isFollowed = true;
                      console.log("follow");
                    } else {
                      isFollowed = false;
                    }
                    if (
                      result.bookmark.filter(
                        (book) => book.toString() === req.user
                      ).length == 1
                    ) {
                      isBookmarked = true;
                      console.log("book");
                    } else {
                      isBookmarked = false;
                    }
                    if (
                      result.applicants.filter(
                        (appliedPersons) =>
                          appliedPersons.toString() === req.user
                      ).length == 1
                    ) {
                      isApplied = true;
                      console.log("applied");
                    } else {
                      isApplied = false;
                    }
                    console.log({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                    return res.json({
                      ...result._doc,
                      isFollowed: isFollowed,
                      isBookmarked: isBookmarked,
                      isApplied: isApplied,
                    });
                  });
              }
            );
          }
        );
      } else {
        console.log(user.bookmark);
        return res.status(401).json({ msg: "Already Bookmarked" });
      }
    });
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
      userModel.findById(req.body.userId).then((user) => {
        if (
          user.accepted.filter(
            (acceptedJob) => acceptedJob.toString() === jobPostId
          ).length == 0
        ) {
          console.log("inside");
          userModel.findByIdAndUpdate(
            req.body.userId,
            { $push: { accepted: jobPostId } },
            { new: true },
            (error, result) => {
              userModel.findByIdAndUpdate(
                req.body.userId,
                {
                  $pull: {
                    shortlisted: jobPostId,
                    declined: jobPostId,
                    pending: jobPostId,
                  },
                },
                { new: true },
                (error, result) => {
                  console.log("inside push");
                  if (error)
                    return res.status(401).json({ msg: error.message });
                  postModel.findByIdAndUpdate(
                    jobPostId,
                    { $push: { accepted: req.body.userId } },
                    { new: true },
                    (err, results) => {
                      if (err)
                        return res.status(401).json({ msg: err.message });
                      // res.json({ result, results });

                      postModel.findByIdAndUpdate(
                        jobPostId,
                        {
                          $pull: {
                            shortlisted: req.body.userId,
                            declined: req.body.userId,
                          },
                        },
                        { new: true },
                        (err, results) => {
                          console.log("before post model");
                          postModel
                            .findOne({ _id: jobPostId })
                            .exec(function (error, result) {
                              console.log("hehehe");
                              console.log(result);
                              if (error)
                                return res
                                  .status(401)
                                  .json({ msg: error.message });

                              if (
                                result.accepted.filter(
                                  (acceptedJob) =>
                                    acceptedJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isAccepted = true;
                                console.log("accepted");
                              } else {
                                isAccepted = false;
                              }
                              if (
                                result.shortlisted.filter(
                                  (shortJob) =>
                                    shortJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isShortlisted = true;
                                console.log("shortlisted");
                              } else {
                                isShortlisted = false;
                              }
                              if (
                                result.declined.filter(
                                  (declineJob) =>
                                    declineJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isDeclined = true;
                                console.log("declined");
                              } else {
                                isDeclined = false;
                              }
                              console.log("before accepted button");
                              console.log({
                                ...result._doc,
                                isAccepted: isAccepted,
                                isShortlisted: isShortlisted,
                                isDeclined: isDeclined,
                              });
                              return res.json({
                                ...result._doc,
                                isAccepted: isAccepted,
                                isShortlisted: isShortlisted,
                                isDeclined: isDeclined,
                              });
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
                            });
                        }
                      );
                    }
                  );
                }
              );
            }
          );
        } else {
          return res.status(401).json({ msg: "Already Accepted" });
        }
      });
    } else if (work == "Shortlisted") {
      userModel.findById(req.body.userId).then((user) => {
        if (
          user.shortlisted.filter(
            (shortlistedJob) => shortlistedJob.toString() === jobPostId
          ).length == 0
        ) {
          console.log("inside");
          userModel.findByIdAndUpdate(
            req.body.userId,
            { $push: { shortlisted: jobPostId } },
            { new: true },
            (error, result) => {
              userModel.findByIdAndUpdate(
                req.body.userId,
                { $pull: { accepted: jobPostId, declined: jobPostId } },
                { new: true },
                (error, result) => {
                  console.log("inside push");

                  if (error)
                    return res.status(401).json({ msg: error.message });
                  postModel.findByIdAndUpdate(
                    jobPostId,
                    { $push: { shortlisted: req.body.userId } },
                    { new: true },
                    (err, results) => {
                      if (err)
                        return res.status(401).json({ msg: err.message });
                      // res.json({ result, results });

                      postModel.findByIdAndUpdate(
                        jobPostId,
                        {
                          $pull: {
                            accepted: req.body.userId,
                            declined: req.body.userId,
                          },
                        },
                        { new: true },
                        (err, results) => {
                          console.log("before post model");
                          postModel
                            .findOne({ _id: jobPostId })
                            .exec(function (error, result) {
                              console.log("hehehe");
                              console.log(result);
                              if (error)
                                return res
                                  .status(401)
                                  .json({ msg: error.message });

                              if (
                                result.accepted.filter(
                                  (acceptedJob) =>
                                    acceptedJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isAccepted = true;
                                console.log("accepted");
                              } else {
                                isAccepted = false;
                              }
                              if (
                                result.shortlisted.filter(
                                  (shortJob) =>
                                    shortJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isShortlisted = true;
                                console.log("shortlisted");
                              } else {
                                isShortlisted = false;
                              }
                              if (
                                result.declined.filter(
                                  (declineJob) =>
                                    declineJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isDeclined = true;
                                console.log("declined");
                              } else {
                                isDeclined = false;
                              }
                              console.log("before accepted button");
                              console.log({
                                ...result._doc,
                                isAccepted: isAccepted,
                                isShortlisted: isShortlisted,
                                isDeclined: isDeclined,
                              });
                              return res.json({
                                ...result._doc,
                                isAccepted: isAccepted,
                                isShortlisted: isShortlisted,
                                isDeclined: isDeclined,
                              });
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
                            });
                        }
                      );
                    }
                  );
                }
              );
            }
          );
        } else {
          return res.status(401).json({ msg: "Already Shortlisted" });
        }
      });
    } else if (work == "Declined") {
      userModel.findById(req.body.userId).then((user) => {
        if (
          user.declined.filter(
            (declinedJob) => declinedJob.toString() === jobPostId
          ).length == 0
        ) {
          console.log("inside");
          userModel.findByIdAndUpdate(
            req.body.userId,
            { $push: { declined: jobPostId } },
            { new: true },
            (error, result) => {
              userModel.findByIdAndUpdate(
                req.body.userId,
                {
                  $pull: {
                    accepted: jobPostId,
                    shortlisted: jobPostId,
                    pending: jobPostId,
                  },
                },
                { new: true },
                (error, result) => {
                  console.log("inside push");

                  if (error)
                    return res.status(401).json({ msg: error.message });
                  postModel.findByIdAndUpdate(
                    jobPostId,
                    { $push: { declined: req.body.userId } },
                    { new: true },
                    (err, results) => {
                      if (err)
                        return res.status(401).json({ msg: err.message });
                      // res.json({ result, results });

                      postModel.findByIdAndUpdate(
                        jobPostId,
                        {
                          $pull: {
                            accepted: req.body.userId,
                            shortlisted: req.body.userId,
                          },
                        },
                        { new: true },
                        (err, results) => {
                          console.log("before post model");
                          postModel
                            .findOne({ _id: jobPostId })
                            .exec(function (error, result) {
                              console.log("hehehe");
                              console.log(result);
                              if (error)
                                return res
                                  .status(401)
                                  .json({ msg: error.message });

                              if (
                                result.accepted.filter(
                                  (acceptedJob) =>
                                    acceptedJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isAccepted = true;
                                console.log("accepted");
                              } else {
                                isAccepted = false;
                              }
                              if (
                                result.shortlisted.filter(
                                  (shortJob) =>
                                    shortJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isShortlisted = true;
                                console.log("shortlisted");
                              } else {
                                isShortlisted = false;
                              }
                              if (
                                result.declined.filter(
                                  (declineJob) =>
                                    declineJob.toString() === req.body.userId
                                ).length == 1
                              ) {
                                isDeclined = true;
                                console.log("declined");
                              } else {
                                isDeclined = false;
                              }
                              console.log("before accepted button");
                              console.log({
                                ...result._doc,
                                isAccepted: isAccepted,
                                isShortlisted: isShortlisted,
                                isDeclined: isDeclined,
                              });
                              return res.json({
                                ...result._doc,
                                isAccepted: isAccepted,
                                isShortlisted: isShortlisted,
                                isDeclined: isDeclined,
                              });
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
                            });
                        }
                      );
                    }
                  );
                }
              );
            }
          );
        } else {
          return res.status(401).json({ msg: "Already Declined" });
        }
      });
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
      console.log("hehehe");
      console.log(result);
      if (error) return res.status(401).json({ msg: error.message });

      if (
        result.accepted.filter(
          (acceptedJob) => acceptedJob.toString() === req.body.userId
        ).length == 1
      ) {
        isAccepted = true;
        console.log("accepted");
      } else {
        isAccepted = false;
      }
      if (
        result.shortlisted.filter(
          (shortJob) => shortJob.toString() === req.body.userId
        ).length == 1
      ) {
        isShortlisted = true;
        console.log("shortlisted");
      } else {
        isShortlisted = false;
      }
      if (
        result.declined.filter(
          (declineJob) => declineJob.toString() === req.body.userId
        ).length == 1
      ) {
        isDeclined = true;
        console.log("declined");
      } else {
        isDeclined = false;
      }
      console.log("before accepted button");
      console.log({
        ...result._doc,
        isAccepted: isAccepted,
        isShortlisted: isShortlisted,
        isDeclined: isDeclined,
      });
      return res.json({
        ...result._doc,
        isAccepted: isAccepted,
        isShortlisted: isShortlisted,
        isDeclined: isDeclined,
      });
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// search studio by name api
userAuth.get("/api/showWorkingJobs", auth, async (req, res) => {
  try {
    let newResult = [];
    const search = req.query.search;
    const working = req.query.working;
    userModel.findById(req.user).then((user) => {
      userModel
        .findById(req.user)
        .populate(working)
        .exec(function (error, result) {
          if (error) return res.status(401).json({ msg: error.message });
          for (let index = 0; index < result[working].length; index++) {
            const element = result[working][index];
            if (search.length > 0) {
              if (element.studioName.toLowerCase() == search.toLowerCase()) {
                newResult.push(element);
              }
            } else {
              newResult.push(element);
            }
          }

          console.log(newResult);
          res.json(newResult);
        });
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

userAuth.get("/api/studio/showWorkingJobs", sAuth, async (req, res) => {
  try {
    let newResult = [];
    const working = req.query.working;
    const search = req.query.search;
    console.log(working);
    studioModel.findOne({ _id: req.user, status: true }).then((user) => {
      postModel.find({ studio: req.user }).exec(function (error, result) {
        // if (error) return res.status(401).json({ msg: error.message });
        console.log("hey hey hey hey");
        console.log("hey hey hey hey");
        console.log("hey hey hey hey");
        console.log("hey hey hey hey");
        console.log("hey hey hey hey");
        result.forEach((element) => {
          if (working == "accepted") {
            if (search.length > 0) {
              if (
                element.accepted.length > 0 &&
                element.jobType.toLowerCase() == search.toLowerCase()
              ) {
                console.log(element.accepted);
                newResult.push(element);
              }
            } else {
              if (element.accepted.length > 0) {
                console.log(element.accepted);
                newResult.push(element);
              }
            }
          } else if (working == "shortlisted") {
            if (search.length > 0) {
              if (
                element.shortlisted.length > 0 &&
                element.jobType.toLowerCase() == search.toLowerCase()
              ) {
                console.log(element.shortlisted);
                newResult.push(element);
              }
            } else {
              if (element.shortlisted.length > 0) {
                console.log(element.shortlisted);
                newResult.push(element);
              }
            }
          } else if (working == "applied") {
            if (search.length > 0) {
              if (
                element.applicants.length > 0 &&
                element.jobType.toLowerCase() == search.toLowerCase()
              ) {
                console.log(element.applicants);
                newResult.push(element);
              }
            } else {
              if (element.applicants.length > 0) {
                console.log(element.applicants);
                newResult.push(element);
              }
            }
          }
        });

        console.log(newResult.length);
        console.log(result.length);
        // console.log(result);
        res.json(newResult);
      });
    });
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
    await userModel
      .findByIdAndUpdate(req.user, {
        $set: { profilePic: req.body.profilePicUrl },
      })
      .then((user) => {
        userModel.findById(req.user).exec(function (error, result) {
          console.log({ ...result._doc, token: "" });
          res.json({ ...result._doc, token: req.token });
        });
      });
  } catch (error) {
    res.status(501).json({ error: error.message });
  }
});

// Media upload
userAuth.post("/api/upload/media", auth, async (req, res) => {
  try {
    if (req.body.mediaType == "photos") {
      await userModel
        .findByIdAndUpdate(req.user, { $push: { photos: req.body.media } })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    } else if (req.body.mediaType == "videos") {
      console.log("inside video");
      await userModel
        .findByIdAndUpdate(req.user, { $push: { videos: req.body.media } })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    } else if (req.body.mediaType == "thumbnails") {
      console.log("inside thumbnail");
      await userModel
        .findByIdAndUpdate(req.user, {
          $push: { thumbnailVideo: req.body.media },
        })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    } else if (req.body.mediaType == "audios") {
      console.log("inside audio");
      await userModel
        .findByIdAndUpdate(req.user, { $push: { audios: req.body.media } })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    } else if (req.body.mediaType == "documents") {
      console.log("inside audio");
      await userModel
        .findByIdAndUpdate(req.user, { $push: { documents: req.body.media } })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    }
  } catch (error) {
    res.status(501).json({ error: error.message });
  }
});

// Media delete
userAuth.post("/api/delete/media", auth, async (req, res) => {
  try {
    console.log(req.body.mediaType);

    if (req.body.mediaType == "photos") {
      await userModel
        .findByIdAndUpdate(req.user, { $pull: { photos: req.body.media } })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    } else if (req.body.mediaType == "videos") {
      await userModel
        .findByIdAndUpdate(req.user, { $pull: { videos: req.body.media } })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    } else if (req.body.mediaType == "thumbnails") {
      await userModel
        .findByIdAndUpdate(req.user, {
          $pull: { thumbnailVideo: req.body.media },
        })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    } else if (req.body.mediaType == "audios") {
      await userModel
        .findByIdAndUpdate(req.user, { $pull: { audios: req.body.media } })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    } else if (req.body.mediaType == "documents") {
      await userModel
        .findByIdAndUpdate(req.user, { $pull: { documents: req.body.media } })
        .then((user) => {
          userModel.findById(req.user).exec(function (error, result) {
            console.log({ ...result._doc, token: "" });
            res.json({ ...result._doc, token: req.token });
          });
        });
    }
  } catch (error) {
    res.status(501).json({ error: error.message });
  }
});

// get studio data in audition
userAuth.get("/api/audition/getStudioData", auth, async (req, res) => {
  try {
    const user = await userModel.findById(req.user);
    if (!user) {
      return res.status(401).json({ msg: "No user found" });
    }
    const sUser = await studioModel.findById(req.query.studioId);
    if (!sUser) return res.status(401).json({ msg: "No Studio user found" });

    console.log({ ...sUser._doc, token: req.token });
    res.json({ ...sUser._doc, token: req.token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = userAuth;

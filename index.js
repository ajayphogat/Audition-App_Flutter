const express = require("express");
const mongoose = require("mongoose");
const userAuth = require("./auth/audition_user_auth");
const postJob = require("./auth/job_post_studio");
const studioAuth = require("./auth/studio_user_auth");
const switchAuth = require("./auth/switch_account_auth");

const app = express();

const port = process.env.PORT || 3000;
const db = "mongodb+srv://hackingdna:password3@cluster0.uyol6gn.mongodb.net/AuditionDB";
// const db = "mongodb://127.0.0.1:27017/AuditionDB";
// const db = "mongodb://127.0.0.1:27017/AuditionDB";

// Middlewares
app.use(express.json());
app.use(userAuth);
app.use(studioAuth);
app.use(switchAuth);
app.use(postJob);

//connect to db
mongoose.connect(db).then(
    () => {
        console.log("Connected to Database successfully");
    }
).catch(
    (error) => {
        console.log(`Error is ${error}`);
    }
);

app.get("/a", async (req, res) => {
    res.send("<h1>Welcome</h1>");
});



app.listen(port, () => {
    console.log(`Server started at port ${port}`);
});










// {
//     "studioName": "Marvel Studio",
//     "jobType": "Actor",
//     "socialMedia": "facebook.com",
//     "description": "Marvel Studio is my favourite studio. I love Iron man and want him to come back with some big bang movies.",
//     "productionDetail": "I am waiting for wolverien X deadpool movie which will be awsome. One of the best combination.",
//     "date": "23-05-1997",
//     "location": "Jaipur, Rajasthan",
//     "contactNumber": "9024350276",
//     "keyDetails": "Studio for Marvel and superhero fans",
//     "images": ["first", "second"],
//     "studio": "63747b403a8ccad790548f35",
//     "applicants": []
    
    
//   }
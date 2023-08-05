// require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const userAuth = require("./auth/audition_user_auth");
const postJob = require("./auth/job_post_studio");
const studioAuth = require("./auth/studio_user_auth");
const switchAuth = require("./auth/switch_account_auth");
const adminModel = require("./auth/admin_user");
const managerAuth = require("./auth/manager_user_auth");
const cors = require('cors');
const multer = require("multer");



//cron job like node-cron
const cron = require("node-cron");

mongoose.set('strictQuery', true);

const app = express();

const port = process.env.PORT || 4400; 
//const db = "mongodb+srv://hackingdna:password3@cluster0.uyol6gn.mongodb.net/AuditionDB";
// const db = "mongodb://127.0.0.1:27017/AuditionDB";
//const db = "mongodb://127.0.0.1:27017/AuditionDB";
//const db = "mongodb://43.205.137.240:27017/AuditionDB";
const db = "mongodb://admin:findingyoupassword@3.110.114.32:27017/AuditionDB";


const allowedOrigins = [
  'https://studio.findingyou.media',
  'https://findingyou.media',
  'https://admin.findingyou.media',
  'https://www.findingyou.media',
  'http://localhost:3000',
];

// Middlewares
app.use(cors({
	origin:allowedOrigins,
}));

//app.options('*', cors());

app.use(express.json());
app.use(userAuth);
app.use(studioAuth);
app.use(switchAuth);
app.use(postJob);
app.use(adminModel);
app.use(managerAuth);

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

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "uploads/");
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const uploadImages = multer({
    storage: storage
})

app.post("/a", uploadImages.single("uploadImage"), async (req, res) => {
    console.log(req.files);
    res.json({msg: "Got it"});
});

app.get("/studentdata", async(req, res) => {
    res.json({
        "name": "Rahul Dey",
        "roll": "30",
        "cl": "5",
        "hobby": "cooking",
    });
})


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

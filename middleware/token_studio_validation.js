const jwtKey = require("../constant/const_studio");
const jwt = require("jsonwebtoken");

const sAuth = async (req, res, next) => {
    try {
        const token = req.header("x-studio-token");
        if (!token) {
            console.log("token not found");
            return res.status(401).json({ msg: "No token found! Authentication Failed" });
        }
        const verified = jwt.verify(token, jwtKey);

        if (!verified) {
            console.log("token not valid");
            return res.status(401).json({ msg: "Token verification failed! Authorization Denied" });
        }
        req.user = verified.id;
        req.token = token;
        next();
    } catch (error) {
        res.status(501).json({ error: error.message });
    }
}

module.exports = sAuth;
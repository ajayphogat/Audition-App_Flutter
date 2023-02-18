const adminJwtKey = require("../constant/const_admin");
const jwt = require("jsonwebtoken");

const aAuth = async (req, res, next) => {
    try {
        const token = req.header("x-admin-token");
        if (!token) {
            console.log("token not found");
            return res.status(401).json({ msg: "No token found! Authentication Failed" });
        }
        const verified = jwt.verify(token, adminJwtKey);

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

module.exports = aAuth;
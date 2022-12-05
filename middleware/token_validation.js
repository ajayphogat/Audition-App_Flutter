const jwt = require("jsonwebtoken");
const jwtKey = require("../constant/const_variable");


const auth = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) {
            return res.status(401).json({ msg: "No token found! Authentication Failed" });
        }
        const verified = jwt.verify(token, jwtKey);

        if (!verified) {
            return res.status(401).json({ msg: "Token verification failed! Authorization Denied" });
        }
        req.user = verified.id;
        req.token = token;
        next();

    } catch (error) {
        res.status(501).json({ error: error.message });
    }
}

module.exports = auth;
const jwt = require('jsonwebtoken')

//* check if user have token (auth) 
module.exports = function (req, res, next) {
    //* get the token from header called x-auth-token 
    const token = req.header('x-auth-token')
    if (!token) {
        res.status(401).send('access denied not auth......')
    }

    try {
        //* decode the token to get the user info using package jsonwebtoken
        const decodeToken = jwt.verify(token, 'privateKey')
        req.user = decodeToken

        console.log(decodeToken)
        next()

    } catch (er) {
        res.status(400).send('wrong token ......')
    }
}
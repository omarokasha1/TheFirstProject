const jwt = require('jsonwebtoken')


//* check by token if the user is admin or not 
module.exports = function (req, res, next) {
    const token = req.header('x-auth-token')
    if (!req.user.isAdmin) {
        console.log(req.user.isAdmin)
        return res.status(403).send('access denied not admin......')
    }

    try {
        //* decode the token to get the user info to ensure that he is an admin using package jsonwebtoken
        const decodeToken = jwt.verify(token, 'privateKey')
        req.user = decodeToken
    } catch (error) {
        res.status(400).send('wrong token .....')
    }
    next()


}
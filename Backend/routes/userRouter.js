const router = require('express').Router()
const userCtrl = require('../controllers/userController')
const courseCtrl = require('../controllers/courseController')
const authGoogle = require('../middleware/authGoogle')
const authAdmin = require('../middleware/admin')
const auth = require('../middleware/auth')
 
/*Next, we go for the POST request. We create a 
new user in the database and then return the 
created user as a response.  */

router.post('/register', userCtrl.register)
router.post('/activation', userCtrl.activateEmail)
router.post('/login', userCtrl.login)
router.post('/refresh_token', userCtrl.getAccessToken)
router.post('/forgot', userCtrl.forgotPassword)
router.post('/reset', auth, userCtrl.resetPassword)
// login as normal user  -> refresh_token -> grtUserInfo
router.get('/infor', auth, userCtrl.getUserInfor)
// login as admin -> refresh_token -> grtAllUsersInfo
router.get('/all_infor', auth, authAdmin, userCtrl.getUsersAllInfor)
router.get('/logout', userCtrl.logout)
// login as normal user   -> refresh_token -> update
router.put('/update', auth, userCtrl.updateUser)
// login as admin -> refresh_token -> update
router.patch('/update_role/:id', auth, authAdmin, userCtrl.updateUsersRole)
router.delete('/delete/:id', auth, authAdmin, userCtrl.deleteUser)


const multer = require('multer');
const path = require('path')
//define storage for the images
const storage = multer.diskStorage({
  //destination for files
  destination: function (request, file, callback) {
    callback(null, './uploads/');
  },

  //add back the extension
  filename: function (request, file, callback) {
    let ext = path.extname(file.originalname)
    callback(null, Date.now() + ext);
  },
});

//upload parameters for multer
const uploads = multer({
  storage: storage,
  limits: {
    fieldSize: 1024 * 1024 * 2,
  },
});

router.post(
    '/upload-profile',
    auth,
    uploads.single('profile'),
    userCtrl.uploadProfile
  );

  router.post(
    '/newCourse',
    auth,
   multer().single('file'),
    courseCtrl.uploadCourse
  );
module.exports = router
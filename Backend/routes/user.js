const express = require('express')
const userCtrl =require('../controllers/userController')
const router = express.Router()
const auth = require('../middleware/auth')
const multer = require('multer');
const path = require('path');


//define storage for the images

const storage = multer.diskStorage({
    //destination for files
    destination: function (request, file, callback) {
      callback(null, './uploads');
    },
  
    //add back the extension
    filename: function (request, file, callback) {
      callback(null, new Date().toISOString()+file.originalname)
    },
  });
  
  //upload parameters for multer
  const upload = multer({
    storage: storage,
    limits: {
      fieldSize: 1024 * 1024 * 3,
    },
  });

  router.post(
    '/upload-profile',
    auth,
    upload.single('profile'),
    userCtrl.uploadProfile
  );
  
  router.post(
    '/upload',
    auth,
    upload.single('profile'),
    userCtrl.uploadImage
  );

router.post('/register',userCtrl.register )

router.post('/login', userCtrl.login)

//* middleware auth check first if user loged in and have a token 
router.get('/get-profile', auth, userCtrl.profile)

// Updating One
router.put('/update-profile',[ upload.single('imageUrl'),auth,userCtrl.updateProfile])

// change password
router.post('/change-password',[auth,userCtrl.changePassword] )

// Getting all
router.get('/allUsers',userCtrl.allUsers )

module.exports = router
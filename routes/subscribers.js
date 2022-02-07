const express = require('express')
const router = express.Router()
const Subscriber = require('../models/subscriber')
const auth = require('../middleware/auth')
const admin = require('../middleware/admin')

// Getting all
router.get('/', async (req, res) => {
  try {
    const subscribers = await Subscriber.find()
    res.json(subscribers)
  } catch (err) {
    res.status(500).json({ message: err.message })
  }
})

router.get('/pages', async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query
    const subscribers = await Subscriber.find().sort('name').limit(limit * 1).skip((page - 1) * limit).exec()
    res.json(subscribers)
  } catch (err) {
    res.status(500).json({ message: err.message })
  }
})

// Getting One
router.get('/:id', getSubscriber, (req, res) => {

  res.json(res.subscriber)
})

// Creating one
router.post('/', async (req, res) => {
  const subscriber = new Subscriber({
    userName: req.body.userName,
    email: req.body.email,
    password: req.body.password
  })
  try {
    const newSubscriber = await subscriber.save()
    res.status(201).json(newSubscriber)
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
})

// Updating One
router.patch('/:id', getSubscriber, async (req, res) => {
  if (req.body.name != null) {
    res.subscriber.name = req.body.name
  }
  if (req.body.subscribedToChannel != null) {
    res.subscriber.subscribedToChannel = req.body.subscribedToChannel
  }
  try {
    const updatedSubscriber = await res.subscriber.save()
    res.json(updatedSubscriber)
  } catch (err) {
    res.status(400).json({ message: err.message })
  }
})

// Deleting One
router.delete('/:id', [auth, admin], getSubscriber, async (req, res) => {
  try {
    await res.subscriber.remove()
    res.json({ message: 'Deleted Subscriber' })
  } catch (err) {
    res.status(500).json({ message: err.message })
  }
})

//register sub

router.post('/', async (req, res) => {
  const { userName, email, password: plainTextPassword } = req.body
  const validateError = validateUser(req.body)
  if (validateError.error) {
    return res.json({ error: validateError.error.details[0].message })
  }

  let user = await Users.findOne({ email }).lean()

  if (user) {
    return res.status(404).json({ status: 'error', error: 'email already in use' })
  }
  try {

    user = new Users(_.pick(req.body, ['userName', 'email', 'password']))
    user.password = await bcrypt.hash(plainTextPassword, 10)
    const token = jwt.sign({ id: user.id }, 'privateKey')
    await user.save()

    console.log(user)
    return res.header('x-auth-token', token).json(_.pick(user, ['_id', 'userName', 'email']))
  } catch (error) {
    return res.json({ status: 'error', error: error.message })

  }
})

async function getSubscriber(req, res, next) {
  let subscriber
  try {
    subscriber = await Subscriber.findById(req.params.id)
    if (!subscriber) {
      return res.status(404).json({ status: 'false', message: 'Cannot find subscriber' })
    }
    res.subscriber = subscriber
  } catch (err) {
    return res.status(500).json({ message: err.message })
  }

  res.subscriber = subscriber
  next()
}

module.exports = router
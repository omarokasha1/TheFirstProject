const winston = require('winston');
require('winston-mongodb');
require('dotenv').config()

const logger = winston.createLogger({
    level: 'info',
    format: winston.format.json(),
    transports: [
        //* save errors log in file to can read it at any time even database is down
        new winston.transports.File({
            filename: 'error.log',
            level: 'error',
            format: winston.format.combine(winston.format.timestamp(), winston.format.json())
        }),
        //* save errors log in database to can read it at any time
        new winston.transports.MongoDB({
            db: process.env.DATABASE_URL,
            options: { useUnifiedTopology: true },
            level: 'error',

        }),


    ],
});

module.exports = logger
const { Pool } = require('pg');

// Setup PostgreSQL connection
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'mydb',
    password: '<your-password>',
    port: 5432,
});

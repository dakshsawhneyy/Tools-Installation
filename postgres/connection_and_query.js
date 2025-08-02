// First Install PG Library
npm install pg

// Then in code, write this
const { Pool } = require('pg');

// Setup PostgreSQL connection
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'mydb',
    password: '<your-password>',
    port: 5432,
});

if (log['level'] == 'ERROR' || log['level'] == 'CRITICAL'){
    console.log('Inserting log into database ...');
    await pool.query(
        'INSERT INTO logs (timestamp, level, message) VALUES ($1, $2, $3)',
        [log['timestamp'], log['level'], log['message']]
    )
}

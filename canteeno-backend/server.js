const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 5001;

// Middleware
app.use(cors());
app.use(express.json());

// const PORT = process.env.PORT || 5001; // Change 5000 to 5001
// app.listen(PORT, () => {
//   console.log(`Server is running on port ${PORT}`);
// });
// MongoDB Connection
mongoose.connect(process.env.MONGO_URI, {
  // useNewUrlParser: true,
  // useUnifiedTopology: true,
})
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('Connection error:', err));

// Example Route
app.get('/', (req, res) => {
    res.send('Canteeno Backend API');
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});

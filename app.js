const express = require('express');
const { Sequelize, DataTypes } = require('sequelize');

const app = express();

// Connect to PostgreSQL
const sequelize = new Sequelize('phones_store', 'root', 'lol123', {
  host: 'localhost', // or '127.0.0.1'
  port: 5432,
  dialect: 'postgres',
});

// Define models
const Brand = sequelize.define('Brand', {
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
});

const Category = sequelize.define('Category', {
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
});

// Define other models similarly for the remaining tables

// Define routes
app.get('/brands', async (req, res) => {
  const brands = await Brand.findAll();
  res.json(brands);
});

app.get('/categories', async (req, res) => {
  const categories = await Category.findAll();
  res.json(categories);
});

// Define other routes similarly for the remaining tables

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

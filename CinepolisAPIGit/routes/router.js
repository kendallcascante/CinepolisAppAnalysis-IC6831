const varController = require('../controllers/SPControllers.js');
const express = require('express');
const router = express.Router();

router.post("/register", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().register(req, res);
});
router.post("/registerMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().registerMovie(req, res);
});
router.post("/deleteMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteMovie(req, res);
})
router.post("/addFood", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addFood(req, res);
})
router.post("/deleteFood", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteFood(req, res);
})
router.post("/addFoodToCart", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addFoodToCart(req, res);
})
router.options("/*", (req, res) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
    res.header('Access-Control-Allow-Headers', '*');
    res.status(204).send();
    console.log(req.headers)
});
module.exports=router;

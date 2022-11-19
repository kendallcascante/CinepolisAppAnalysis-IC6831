const varController = require('../controllers/SPControllers.js');
const express = require('express');
const router = express.Router();

router.get("/getMovies", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getMovies(req, res);
});
router.post("/getFunctions", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getFunctions(req, res);
});
router.post("/register", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().register(req, res);
});
router.post("/logIn", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().logIn(req, res);
});
router.post("/registerMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().registerMovie(req, res);
});
router.get("/getGenres", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getGenres(req, res);
});
router.get("/getLanguages", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getLanguages(req, res);
});
router.get("/getVaccines", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getVaccines(req, res);
});
router.post("/addGenre", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addGenre(req, res);
});
router.post("/addLanguage", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addLanguage(req, res);
});
router.post("/deleteLanguage", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteLanguage(req, res);
});
router.post("/addParticipant", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addParticipant(req, res);
});
router.post("/deleteParticipant", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteParticipant(req, res);
});
router.post("/addPrice", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addPrice(req, res);
});
router.post("/deletePrice", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deletePrice(req, res);
});
router.post("/languagesPerMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getLanguagesPerMovie(req, res);
});
router.post("/genresPerMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getGenresPerMovie(req, res);
})
router.post("/participantsPerMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getParticipantsPerMovie(req, res);
})
router.post("/pricesPerMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getPricesPerMovie(req, res);
})
router.post("/addFunction", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addFunction(req, res);
})
router.post("/deleteUser", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteUser(req, res);
})
router.post("/deleteMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteMovie(req, res);
})
router.post("/updateMovie", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().updateMovie(req, res);
})
router.post("/updateUser", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().updateUser(req, res);
})
router.post("/addFood", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addFood(req, res);
})
router.post("/deleteFood", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteFood(req, res);
})
router.post("/updateFood", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().updateFood(req, res);
})
router.post("/getFoods", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getFoods(req, res);
})
router.post("/getSeats", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getSeats(req, res);
})
router.post("/addTicket", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addTicketToCart(req, res);
})
router.post("/addTicketToCart", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addTicketToCart(req, res);
})
router.post("/removeTicketFromCart", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().removeTicketsFromCart(req, res);
})
router.post("/addFoodToCart", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().addFoodToCart(req, res);
})
router.post("/removeFoodFromCart", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().removeFoodFromCart(req, res);
})
router.post("/getCart", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getCart(req, res);
})
router.post("/bill", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().createBill(req, res);
})
router.get("/getUsers", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getUsers(req, res);
})
router.post("/getData",(req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getData(req, res);
})
router.get("/getCinemaRooms", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().getCinemaRooms(req, res);
})
router.post("/deleteFunction", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteFunction(req, res);
})
router.post("/updateFunction", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().updateFunction(req, res);
})
router.post("/deleteGenre", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().deleteGenre(req, res);
})
router.post("/updateGenre", (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    varController.getInstance().updateGenre(req, res);
})
router.options("/*", (req, res) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
    res.header('Access-Control-Allow-Headers', '*');
    res.status(204).send();
    console.log(req.headers)
});
module.exports=router;
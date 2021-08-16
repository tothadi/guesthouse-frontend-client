const express = require("express");
const path = require("path");
const favicon = require("serve-favicon");
const app = express();
const port = process.env.PORT || 3000;

// Feliratkozás a middlewar-ekre
app.use(express.json())
    .use(
        express.urlencoded({
            extended: true,
        })
    )
    .use(favicon(__dirname + "/client/favicon.ico"))
    .use(express.static(path.join(__dirname, "client")))

    .get("*", function (req, res) {
        res.sendFile(path.join(__dirname, "client/index.html"));
    })

    // catch 404 and forward to error handler
    .use(function (req, res, next) {
        const err = new Error("Not Found");
        err.status = 404;
        next(err);
    })

    // error handlers

    // [SH] Catch unauthorised errors
    .use(function (err, req, res, next) {
        if (err.name === "UnauthorizedError") {
            res.status(401);
            res.json({ message: err.name + ": " + err.message });
        }
    })

    // production error handler
    // no stacktraces leaked to user
    .use(function (err, req, res, next) {
        res.status(err.status || 500);
        res.render("error", {
            message: err.message,
            error: {},
        });
    });

const server = app.listen(port, () => {
    console.log(`Server listening on port: ${port}`);
});

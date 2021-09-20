const express = require("express")

const app = express()
const cors =  require("cors")
app.use(cors())
app.use(express.static(__dirname+"/uploads"))
const user = require('./routes/user')
const admin = require("./routes/admin")
app.use(express.urlencoded({extended:true}));
app.use(express.json())
app.set('view engine', 'pug');
app.set('views','./views');

app.get("/",(req,res)=>{
    res.send("home page")
})


app.use("/user",user)

app.use("/admin",admin)

app.listen(8888,()=>{
    console.log("running in 8888");
})


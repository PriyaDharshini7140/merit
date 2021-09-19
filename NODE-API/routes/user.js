const express =  require("express")
const router =  express.Router()
const { MongoClient ,ObjectId} = require('mongodb');
const url = 'mongodb://localhost:27017';

let multer = require("multer")
let path =  require("path")
router.use(express.static(__dirname+"/uploads"))
const storage = multer.diskStorage({
    destination:(req,file,cb)=>{
          cb(null,__dirname+"/uploads")
    },
    filename:(req,file,cb)=>{
        // console.log(file);
        var fileext = path.extname(file.originalname)
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9)
        cb(null,file.fieldname+'-'+uniqueSuffix+fileext)
    }
})

const upload = multer({storage:storage})

router.get("/students",(req,res)=>{
    MongoClient.connect(url,(err,con)=>{
        var db = con.db("practice")
        db.collection("stud").find().toArray((err,data)=>{
            console.log(data);
            res.send(data)
        })
        })
})

router.post("/register",upload.single("pic"),(req,res)=>{
    console.log(req.body);
    console.log(req.file);
    req.body.profile=req.file.filename
    MongoClient.connect(url,(err,con)=>{
    var db = con.db("practice")
     db.collection("stud").insertOne(req.body,(err,data)=>{
         console.log(data);
         res.send("registered successfully")
     })
     
    });
  
})


router.get("/particularuser/:id",(req,res)=>{
    MongoClient.connect(url,(err,con)=>{
    var db = con.db("practice")
     db.collection("stud").findOne({_id:ObjectId(req.params.id)},(err,data)=>{
       res.send(data)
     })
     
    });
  
})
app.post("/updateprofile",upload.single("pic"),function(req,res){
    console.log(req.body);
    console.log(req.file)
    MongoClient.connect(url,function(err,conn){
        console.log("body",req.body)
        var db = conn.db("practice");
        db.collection("stud").updateOne({_id:ObjectId(req.body.id)},
        {
            $set:{
                pic:req.file.filename
            }
        }
        ,(err,data)=>{
          console.log(data);
           res.send(data)
        
          })
    })
})


module.exports = router;
const express =  require("express")
const router =  express.Router()
const { MongoClient ,ObjectId} = require('mongodb');
const url = 'mongodb://localhost:27017';

router.get("/admin",(req,res)=>{
    MongoClient.connect(url,(err,con)=>{
        var db = con.db("practice")
        db.collection("admin").find().toArray((err,data)=>{
            console.log(data);
            res.send(data)
        })
        })
})

router.post("/registeradmin",(req,res)=>{
    console.log(req.body);
    MongoClient.connect(url,(err,con)=>{
    var db = con.db("practice")
     db.collection("admin").insertOne(req.body,(err,data)=>{
         console.log(data);
         res.send("registered successfully")
     })
     
    });
  
})

app.get("/delete/:id",(req,res)=>{
    MongoClient.connect(url,(err,con)=>{
    var db = con.db("practice")
     db.collection("admin").deleteOne({_id:ObjectId(req.params.id)},(err,data)=>{
         res.send("deleted")
     })
     
    });
  
})

app.post("/updateprofile",function(req,res){
    console.log(req.body);
    MongoClient.connect(url,function(err,conn){
        console.log("body",req.body)
        var db = conn.db("practice");
        db.collection("admin").updateOne({_id:ObjectId(req.body.id)},
        {
            $set:{
                admin_name:req.body.admin_name
            }
        }
        ,(err,data)=>{
          console.log(data);
           res.send(data)
        
          })
    })
})




module.exports = router;
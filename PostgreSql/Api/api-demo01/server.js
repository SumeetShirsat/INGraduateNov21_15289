const express=require('express');
const cors=require('cors');
const server=express();
const port=3000;
const CORS_OPTIONS={origin:'http://localhost:3000'};
server.use(express.json());
server.use(express.urlencoded({extended:true}));
server.use(cors(CORS_OPTIONS));
//################ sync with database
const DB=require('./db/models');
DB.sequelize.sync();
//################ default route:: http://localhost:3500/
server.get('/',(req,resp)=>{
    resp.setHeader("Content-Type","application/json");
    resp.send({message:"Welcome to web-api created using Express Sequelize Postgre"});
})
//################ app with route:: http://localhost:3500/app/
require('./app/app-route')(server);


server.listen(port,()=>{
    console.log(`http://localhost:${port} started`);
})
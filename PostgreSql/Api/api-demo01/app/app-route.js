const { Router } = require('express');

module.exports=app=>{
    const express=require('express');
    const Router=express.Router();
    const PersonControllor=require('./person.controller');
    
    
    //GET url: http://localhost:3500/app/persons
    Router.get('/persons',PersonControllor.findAll);
    //GET url: http://localhost:3500/app/persons/:id
    Router.get('/persons/:id',PersonControllor.findOne);
    //POST url: http://localhost:3500/app/persons/add
    Router.post('/persons/add',PersonControllor.create);
    //PUT url: http://localhost:3500/app/persons/update/:id
    Router.put('/persons/update/:id',PersonControllor.update);
    //DELETE url: http://localhost:3500/app/persons/delete/:id
    Router.delete('/persons/delete/:id',PersonControllor.update);  
    //Main url: http://localhost:3500/app/
    app.use('/app',Router);   
}
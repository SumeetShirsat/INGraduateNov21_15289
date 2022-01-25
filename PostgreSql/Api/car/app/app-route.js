module.exports=(app)=>{
    const express=require('express');
    const ROUTER=express.Router();
    const CarController=require('./car-controller');

    ROUTER.get('/cars',CarController.findAll);

    ROUTER.get('/cars/:id',CarController.findByPk);

     ROUTER.post('/cars/add',CarController.create);

     ROUTER.put('/cars/update/:id',CarController.update);

     ROUTER.delete('/cars/delete/:id',CarController.delete);

    
    app.use('/app',ROUTER);

}
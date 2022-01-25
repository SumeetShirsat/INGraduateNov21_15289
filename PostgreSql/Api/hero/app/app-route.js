module.exports=(app)=>{
    const express=require('express');
    const ROUTER=express.Router();
    const HeroController=require('./hero-controller');

    ROUTER.get('/heroes',HeroController.findAll);

    ROUTER.get('/heroes/:id',HeroController.findByPk);

     ROUTER.post('/heroes/add',HeroController.create);

     ROUTER.put('/heroes/update/:id',HeroController.update);

     ROUTER.delete('/heroes/delete/:id',HeroController.delete);

    
    app.use('/app',ROUTER);

}
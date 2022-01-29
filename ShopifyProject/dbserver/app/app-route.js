module.exports=(app)=>{
  const express=require('express');
  const ROUTER=express.Router();
  const UserController=require('./user-controller');

  ROUTER.get('/users',UserController.findAll);

  ROUTER.get('/users/:id',UserController.findByPk);

   ROUTER.post('/users/add',UserController.create);

   ROUTER.put('/users/update/:id',UserController.update);

   ROUTER.delete('/users/delete/:id',UserController.delete);


  app.use('/app',ROUTER);

}

const db=require('../db/models');//index.js=>db

const Car=db.Car;

// 1. select * from users => findAll

exports.findAll=(req,resp)=>{
    Car.findAll()
        .then(data=>resp.json(data))
        .catch(err=>{
            resp.status(500)
              .send({message:err.message||
                `Something went wrong`})
        });
};

// 2. select * from users where id=?=>findByPK

exports.findByPk=(req,resp)=>{
 const id=parseInt(req.params.id);
    Car.findByPk(id)
        .then(data=>resp.json(data))
        .catch(err=>{
            resp.status(500)
                .send({message:err.message||
                `Something went wrong`})
        });

};

exports.create=(req,res)=>{
    if(!req.body.carName){
        res.status(400)
        .send({message:"Car Name must be provided"});
    }
    const newCar={
        carName:req.body.carName,
        brandName:req.body.brandName,
        createdAt:new Date(),
        updatedAt: new Date()
    }
    Car.create(newCar)
    .then(data=>res.send(data))
    .catch(err=>{
        res.status(500)
        .send({message:err.message})
    })
};

exports.update=(req,res)=>{
    const c_id=parseInt(req.params.id);
    Car.update(req.body,{where:{id:c_id}})
    .then(num=>{
        if(num==1){
        res.send({message:`Car with  id ${c_id} updated sucessfully`});
        }
        else{
        res.send({message:`Car with  id ${c_id} not updated sucessfully`});
        }
        })
        .catch((err) => {
        res.status(500).send({
        message: err.message || " Some error retriving Car data"
        });
        });
};

exports.delete=(req,res)=>{
    const c_id = parseInt(req.params.id);
    Car.destroy({where:{id:c_id}})
    .then(num => {
    if (num == 1) {
    res.send({ message: `Car with id=${c_id} deleted successfully!` });
    } else {
    res.send({ message: `Cannot delete Car with id=${c_id}. Maybe Car was not found!` });
    }
    })
    .catch((err) => {
    res.status(500).send({
    message: err.message || " Could not delete Car with id=" + c_id
    });
    });
};
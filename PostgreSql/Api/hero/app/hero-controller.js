const db=require('../db/models');//index.js=>db

const Hero=db.Hero;

// 1. select * from users => findAll

exports.findAll=(req,res)=>{
    Hero.findAll()
        .then(data=>res.json(data))
        .catch(err=>{
            res.status(500)
              .send({message:err.message||
                `Something went wrong`})
        });
};

// 2. select * from users where id=?=>findByPK

exports.findByPk=(req,res)=>{
 const id=parseInt(req.params.id);
    Hero.findByPk(id)
        .then(data=>res.json(data))
        .catch(err=>{
            res.status(500)
                .send({message:err.message||
                `Something went wrong`})
        });

};

exports.create=(req,res)=>{
    if(!req.body.heroName){
        res.status(400)
        .send({message:"Hero Name must be provided"});
    }
    const newHero={
        heroName:req.body.heroName,
        film:req.body.film,
        createdAt:new Date(),
        updatedAt: new Date()
    }
    Hero.create(newHero)
    .then(data=>res.send(data))
    .catch(err=>{
        res.status(500)
        .send({message:err.message})
    })
};

exports.update=(req,res)=>{
    const c_id=parseInt(req.params.id);
    Hero.update(req.body,{where:{id:c_id}})
    .then(num=>{
        if(num==1){
        res.send({message:`Hero with  id ${c_id} updated sucessfully`});
        }
        else{
        res.send({message:`Hero with  id ${c_id} not updated sucessfully`});
        }
        })
        .catch((err) => {
        res.status(500).send({
        message: err.message || " Some error retriving Hero data"
        });
        });
};

exports.delete=(req,res)=>{
    const c_id = parseInt(req.params.id);
    Hero.destroy({where:{id:c_id}})
    .then(num => {
    if (num == 1) {
    res.send({ message: `Hero with id=${c_id} deleted successfully!` });
    } else {
    res.send({ message: `Cannot delete Hero with id=${c_id}. Maybe Hero was not found!` });
    }
    })
    .catch((err) => {
    res.status(500).send({
    message: err.message || " Could not delete Hero with id=" + c_id
    });
    });
};
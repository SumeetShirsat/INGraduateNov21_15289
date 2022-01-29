const db=require('../db/models');//index.js=>db

const User=db.User;

// 1. select * from users => findAll

exports.findAll=(req,resp)=>{
    User.findAll()
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
    User.findByPk(id)
        .then(data=>resp.json(data))
        .catch(err=>{
            resp.status(500)
                .send({message:err.message||
                `Something went wrong`})
        });

};

exports.create=(req,res)=>{
    if(!req.body.name){
        res.status(400)
        .send({message:"Name must be provided"});
    }
    const newUser={
        name:req.body.name,
        mobileNo:req.body.mobileNo,
        emailId:req.body.emailId,
        password:req.body.password,
        createdAt:new Date(),
        updatedAt: new Date()
    }
    User.create(newUser)
    .then(data=>res.send(data))
    .catch(err=>{
        res.status(500)
        .send({message:err.message})
    })
};

exports.update=(req,resp)=>{
    const c_id=parseInt(req.params.id);
    User.update(req.body,{where:{id:c_id}})
    .then(num=>{
        if(num==1){
        resp.send({message:`User with  id ${c_id} updated sucessfully`});
        }
        else{
        resp.send({message:`User with  id ${c_id} not updated sucessfully`});
        }
        })
        .catch((err) => {
        resp.status(500).send({
        message: err.message || " Some error retriving User data"
        });
        });
};

exports.delete=(req,resp)=>{
    const c_id = parseInt(req.params.id);
    User.destroy({where:{id:c_id}})
    .then(num => {
    if (num == 1) {
    resp.send({ message: `User with id=${c_id} deleted successfully!` });
    } else {
    resp.send({ message: `Cannot delete User with id=${c_id}. Maybe User was not found!` });
    }
    })
    .catch((err) => {
    resp.status(500).send({
    message: err.message || " Could not delete User with id=" + c_id
    });
    });
};

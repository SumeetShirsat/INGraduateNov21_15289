const db=require('../db/models');//index.js=>db

const Book=db.Book;

// 1. select * from users => findAll

exports.findAll=(req,res)=>{
    Book.findAll()
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
    Book.findByPk(id)
        .then(data=>res.json(data))
        .catch(err=>{
            res.status(500)
                .send({message:err.message||
                `Something went wrong`})
        });

};

exports.create=(req,res)=>{
    if(!req.body.bookName){
        res.status(400)
        .send({message:"book Name must be provided"});
    }
    const newBook={
        bookName:req.body.bookName,
        authorName:req.body.authorName,
        publicationDate:req.body.publicationDate,
        createdAt:new Date(),
        updatedAt: new Date()
    }
    Book.create(newBook)
    .then(data=>res.send(data))
    .catch(err=>{
        res.status(500)
        .send({message:err.message})
    })
};

exports.update=(req,res)=>{
    const c_id=parseInt(req.params.id);
    Book.update(req.body,{where:{id:c_id}})
    .then(num=>{
        if(num==1){
        res.send({message:`Book with  id ${c_id} updated sucessfully`});
        }
        else{
        res.send({message:`Book with  id ${c_id} not updated sucessfully`});
        }
        })
        .catch((err) => {
        res.status(500).send({
        message: err.message || " Some error retriving Book data"
        });
        });
};

exports.delete=(req,res)=>{
    const c_id = parseInt(req.params.id);
    Book.destroy({where:{id:c_id}})
    .then(num => {
    if (num == 1) {
    res.send({ message: `Book with id=${c_id} deleted successfully!` });
    } else {
    res.send({ message: `Cannot delete Book with id=${c_id}. Maybe Book was not found!` });
    }
    })
    .catch((err) => {
    res.status(500).send({
    message: err.message || " Could not delete Book with id=" + c_id
    });
    });
};
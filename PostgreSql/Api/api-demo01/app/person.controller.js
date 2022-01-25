const db=require('../db/models');
const Person=db.Person;
//SELECT id, "firstName", "lastName", "createdAt", "updatedAt"
// FROM public."People";	
exports.findAll=(req,resp)=>{
    Person.findAll()
          .then((data)=>{resp.json(data)})
          .catch((err)=>{
              resp.status(500)
                   .send({message:err.message|| " Some Error retriving People Data"})
          })

}
//SELECT id, "firstName", "lastName", "createdAt", "updatedAt"
// FROM public."People" where id=?;	
 exports.findOne=(req,resp)=>{
     console.log("findOne: "+req.params.id);
     const id=parseInt(req.params.id);
     Person.findByPk(id)
           .then((data)=>{
                resp.json(data);
            })
           .catch((err)=>{
               resp.status(500)
                    .send({message:err.message||` Some error retriving Person data with id ${id}`});
           })   
 };
//  INSERT INTO public."People"(
// id, "firstName", "lastName", "createdAt", "updatedAt")
// VALUES (?, ?, ?, ?, ?);
exports.create = (req, resp) => {
    if(!req.body.firstName){
        res.status(400).send({
            message: "Content can not be empty!"
        });
        return;
    }
    const newPerson={
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        createdAt:new Date(),
        updatedAt:new Date()
    }
    Person.create(newPerson)
        .then(data=>{resp.send(data);})
        .catch((err) => {
            resp.status(500).send({
                message: err.message || " Some error Creating new Person data"
            })
        })
}
// UPDATE public."People"
// 	SET id=?, "firstName"=?, "lastName"=?, "createdAt"=?, "updatedAt"=?
// 	WHERE <condition>;
exports.update = (req, resp) => {
    const id = req.params.id;

    Person.update(req.body, { where: { id: id } })
        .then(num => {
            if (num == 1) {
            resp.send({
                message: `People with id ${id} updated successfully.`
            });
            } else {
            resp.send({
                message: `Cannot update Person with id=${id}. Maybe Person was not found or req.body is empty!`
            });
            }
        })
        .catch((err) => {
            resp.status(500).send({
                message: err.message || " Some error retriving People data"
            })
        })
}
// DELETE FROM public."People"
// 	WHERE <condition>;
exports.delete = (req, resp) => {
    const id = req.params.id;
    Person.destroy({ where: { id: id } })
        .then(num => {
            if (num == 1) {
                resp.send({ message: `Person with id=${id} deleted successfully!` });
            } else {
                resp.send({ message: `Cannot delete Person with id=${id}. Maybe Person was not found!` });
            }
        })
        .catch((err) => {
            resp.status(500).send({
                message: err.message || " Could not delete Person with id=" + id
            })
        })
}
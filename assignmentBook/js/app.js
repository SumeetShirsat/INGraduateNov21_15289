const Book=function(bookid,bookName,authorName){

    this.bookid=bookid;

    this.bookName=bookName;
    this.authorName=authorName;

    this.displayDetails=function(){

        return this.bookid+" "+this.bookName+" "+this.authorName;

    }

}



const book1=new Book(1,"Ramayan","Valmiki");
const result=document.getElementById("result");
result.innerHTML=book1.displayDetails();

// document.getElementById("result").innerHTML="<mark>"+person1.getDetais()+"</mark>";

//closure 

// const User=(function (){

//     this.userName="admin";

//     this.password="admin@123";

//     this.displayDetails=function(){

//         return "userName is "+this.userName;

//     }

// });

// const user=new User();

// document.getElementById("result1").innerHTML="<mark>"+user.displayDetails()+"</mark>";
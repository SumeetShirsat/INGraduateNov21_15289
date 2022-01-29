import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators,FormBuilder} from '@angular/forms';
import { Router } from '@angular/router';
import { UserService } from 'src/app/Services/user.service';

@Component({
  selector: 'app-registration',
  templateUrl: './registration.component.html',
  styleUrls: ['./registration.component.css']
})
export class RegistrationComponent implements OnInit {

  form!: FormGroup;

  name = "";
  emailId = "";
  password = "";
  mobileNo = "";


  btnDisabled = false;

  constructor(public userService: UserService,
    private router:Router,private formbuilder:FormBuilder
  ) { }

  ngOnInit(): void {
    this.form = this.formbuilder.group({
      name:[''],
      mobileNo:[''],
      emailId:[''],
      password:['']

    });
    // this.form = new FormGroup({
    //   name: new FormControl('', [Validators.required]),
    //   emailId: new FormControl('',[Validators.required, Validators.email]),
    //   password: new FormControl('',[Validators.required]),
    //   mobileNo: new FormControl('', Validators.required)
    // });
  }

  get f(){
    return this.form.controls;
  }

  submit(){

    this.userService.getUsers().subscribe(res => {
      const user=res.find((a:any)=> {
        return a.emailId != this.form.value.emailId
      });

      if(user){
        alert("Registration Success");
        this.userService.create(this.form.value).subscribe((res:any) => {
                console.log('User created successfully!');
               this.router.navigateByUrl('/login');
           })
        // this.form.reset;
        // this.router.navigateByUrl('/userlist');
      }else{
        alert("User Already Exists");
      }
    },err=>{
      alert("Something went wrong!!");
    })
  }

}


    // alert('User created successfully!');
    // console.log(this.form.value);
    // this.userService.create(this.form.value).subscribe((res:any) => {
    //      console.log('User created successfully!');
    //      this.router.navigateByUrl('/userlist');
    // })




  // submit(){
  //   if(this.form.valid){
  //     alert('User form is valid!!')
  //   } else {
  //     alert('User form is not valid!!')
  //   }
  // }

  // submit(){
  //   alert(this.form.value);
  //    this.userService.create(this.form.value).subscribe((res:any) => {
  //        alert('User created successfully!');
  //         this.router.navigateByUrl('/UserList');

  // }




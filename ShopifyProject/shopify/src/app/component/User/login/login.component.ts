import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators,FormBuilder} from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { UserService } from 'src/app/Services/user.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  form!: FormGroup;

  emailId = "";
  password = "";

  btnDisabled = false;

  constructor(private formbuilder:FormBuilder,
    private router:Router,public userService: UserService,private http: HttpClient
  ) { }

  ngOnInit(): void {
    this.form = this.formbuilder.group({

      emailId:[''],
      password:['']

    });
  }

  login(){
    this.userService.getUsers().subscribe(res => {
      const user=res.find((a:any)=> {
        return a.emailId === this.form.value.emailId && a.password === this.form.value.password
      });

      if(user){
        alert("Login Success");
        this.form.reset;
        this.router.navigateByUrl('/userlist');
      }else{
        alert("User Not Found");
      }
    },err=>{
      alert("Something went wrong!!");
    })
  }

}

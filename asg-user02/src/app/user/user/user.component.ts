import { Component, OnInit } from '@angular/core';
import { UserService } from '../service/user.service';
import { IUser } from './IUser';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css']
})
export class UserComponent implements OnInit {
   users:IUser={id:0, userName:""}

  constructor() { }

  ngOnInit(): void {

  }
  getusers() {

  }

}

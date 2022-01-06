import { Component, OnInit } from '@angular/core';
import { User } from '../user';
import { USERS } from '../mock-users';

@Component({
  selector: 'app-usercomponent',
  templateUrl: './usercomponent.component.html',
  styleUrls: ['./usercomponent.component.css']
})
export class UsercomponentComponent implements OnInit {

  users=USERS;

  // user:User={
  //   id:1,
  //   name:'Sumeet'
  // };

  selectedUser?: User;
onSelect(user: User): void {
  this.selectedUser = user;
}

  constructor() { }

  ngOnInit(): void {
  }

}

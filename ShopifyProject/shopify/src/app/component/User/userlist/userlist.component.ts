import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { UserService } from 'src/app/Services/user.service';
import { first } from 'rxjs/operators';
import { IUser } from 'src/app/IUser';

@Component({
  selector: 'app-userlist',
  templateUrl: './userlist.component.html',
  styleUrls: ['./userlist.component.css']
})
export class UserlistComponent implements OnInit {
  users: IUser[]=[];



  constructor(public userService: UserService,private router:Router) { }

  ngOnInit(): void {
    this.userService.getUsers()
            .pipe(first())
            .subscribe(users => this.users = users);
  }

//   deleteUser(id: string) {
//     const user = this.users.find(x => x.id === id);
//     user.isDeleting = true;
//     this.userService.delete(id)
//         .pipe(first())
//         .subscribe(() => this.users = this.users.filter(x => x.id !== id));
// }

}

import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { IUser } from '../IUser';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  //http://localhost:3000/users/
 private user_urls = "http://localhost:3000/app/users";
 private user_find = "http://localhost:3000/app/users";
 private user_add = "http://localhost:3000/app/users/add";
 private user_update = "http://localhost:3000/app/users/update/";
 private user_delete = "http://localhost:3000/app/users/delete/";

 httpOptions = {
   headers: new HttpHeaders({ 'Content-Type': 'application/json' })
 };
 constructor(private httpclient:HttpClient) { }

 getUsers():Observable<IUser[]>{
   return this.httpclient.get<IUser[]>(this.user_urls);
 };

 find(id:number): Observable<IUser> {
  return this.httpclient.get<IUser>(this.user_find+"/"+id);
}


 create(users: any): Observable<IUser> {
  return this.httpclient.post<IUser>(this.user_add, JSON.stringify(users), this.httpOptions);
}


update(id:number, users: any): Observable<IUser> {
  return this.httpclient.put<IUser>(this.user_update + id, JSON.stringify(users), this.httpOptions)
}

delete(id:number){
  return this.httpclient.delete<IUser>(this.user_delete + id, this.httpOptions)
}


}

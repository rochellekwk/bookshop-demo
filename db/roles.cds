namespace my.bookshop;

using {
  managed,
  cuid,
  User
} from '@sap/cds/common';

type BusinessObject : String(255);

entity Roles : cuid, managed {
  rolename        : String(255)@(title : 'Role Name', );
  description     : String     @(title : 'Description', );
  read            : Boolean    @(title : 'Read', );
  authcreate      : Boolean    @(title : 'Create', );
  authupdate      : Boolean    @(title : 'Update', );
  approve         : Boolean    @(title : 'Approve', );
  BusinessObjects : Composition of many Role_BusinessObject
                      on BusinessObjects.parent = $self;
  Users           : Composition of many Role_User
                      on Users.parent = $self;
};

entity BusinessObjects {
  key ID       : BusinessObject;
      parent   : Association to BusinessObjects;
      children : Composition of many BusinessObjects
                   on children.parent = $self;
};

entity Role_BusinessObject : cuid {
  parent         : Association to Roles;
  BusinessObject : BusinessObject;
};

entity Role_User : cuid {
  parent : Association to Roles;
  user   : User;
};


entity Users {
  key username : String @(title : 'Username', );
      address  : Composition of Address
                   on address.parent = $self;
      role     : Association to Roles;
};

entity Address : cuid, managed {
  parent : Association to Users;
  street : String(60)@(title : 'Street', );
  city   : String(60)@(title : 'City', );
};


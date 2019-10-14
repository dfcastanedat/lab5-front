/* eslint-disable */
<template>
  <div class="hello">
    <h1>Registro GraphQL</h1>
    <h5>Nombre</h5>
    <input type="text" v-model="User.firstName" />
    <h5>Apellido</h5>
    <input type="text" v-model="User.lastName" />
    <h5>Usuario</h5>
    <input type="text" v-model="User.username" />
    <h5>Constraseña</h5>
    <input type="password" v-model="User.password" />
    <br />
    <button @click="mutatethis">Crear con GraphQL</button>
    <button @click="toREST">Crear con REST</button>
    <h2> {{msg}} </h2>
  </div>
</template>

<script>
/* eslint-disable */
import axios from "axios";
import { print } from "graphql";
import gql from "graphql-tag";
export default {
  name: "HelloWorld",
  data() {
    return {
      msg: "",
      User: { firstName: "", lastName: "", username: "", password: "" }
    };
  },
  methods: {
    toREST() {
      axios("localhost:4000/sa-auth-ms/resources/users", {
        method: "POST",
        data: {
          firstName: this.User.firstName,
          lastName: this.User.lastName,
          username: this.User.username,
          password: this.User.password
        }
      })
        .then(response => {
          alert(response.config.data);
          console.log(response);
        })
        .catch(error => {
          console.log(error);
        });
    },
    mutatethis() {

      const CREATE_USER = gql `
        mutation createUser($firstName: String!, $lastName: String!, $username: String!, $password: String!){
          createUser(user: {firstName: $firstName, lastName: $lastName, username: $username, password: $password})
          {
            firstName
            lastName
            username
            password
          }
      }`
      axios({
        method: "POST",
        url: "http://localhost:5000/graphql",
        data:{
          query: print(CREATE_USER),
          variables:{
            firstName: this.User.firstName,
            lastName: this.User.lastName,
            username: this.User.username,
            password: this.User.password
          }
        }
      }).then(response=>{
        this.msg = "Usuario creado satisfactoriamente desde API Gateway: " + "Nombre: " + response.data.data.createUser.firstName + ", Apellido: " + response.data.data.createUser.lastName + ", Nombre Usuario: " + response.data.data.createUser.username + ", Contraseña: " + response.data.data.createUser.password
      });      
      /*
      var firstName=this.User.firstName;
      var lastName=this.User.lastName;
      var ysername=this.User.username;
      var password=this.User.password;
      this.$apollo.mutate({
        mutation: CREATE_USER,
        variables:{
          firstName,
          lastName,
          username,
          password,
        }
      })
      */
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}                firstName
                lastName
                username
                password
h5 {
  text-align: center;
  color: #2c3e50;
}
input {
  color: #2c3e50;
}
button {
  color: #fff !important;
  text-transform: uppercase;
  text-decoration: none;
  background: #2c3e50;
  padding: 20px;
  border-radius: 50px;
  display: inline-block;
  border: none;
  transition: all 0.4s ease 0s;
  margin: 10px;
}
button:hover {
  text-shadow: 0px 0px 20px rgba(255, 255, 255, 1);
  -webkit-box-shadow: 0px 5px 40px -10px rgba(0, 0, 0, 0.57);
  -moz-box-shadow: 0px 5px 40px -10px rgba(0, 0, 0, 0.57);
  transition: all 0.4s ease 0s;
}
</style>

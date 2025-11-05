import mysql from "mysql2";

export const conexion = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "2801",
  database: "proyecto_macrocell"

});

conexion.connect((err) => {
  if (err) {
    console.error("Error al conectar con la base de datos:", err);
  } else {
    console.log("Conexión exitosa a la base de datos");
  }
});

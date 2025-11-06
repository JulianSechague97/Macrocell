import mysql from "mysql2";
import dotenv from "dotenv";

// Cargar variables de entorno
dotenv.config();

// Crear conexión a la base de datos
export const conexion = mysql.createConnection({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "2801",
  database: process.env.DB_NAME || "proyecto_macrocell",
  port: process.env.DB_PORT || 3306
});

// Conectar a la base de datos
conexion.connect((err) => {
  if (err) {
    console.error("❌ Error al conectar con la base de datos:", err.message);
    console.error("📋 Verifica que MySQL esté corriendo y las credenciales sean correctas");
    process.exit(1); // Terminar el proceso si no se puede conectar
  } else {
    console.log("✅ Conexión exitosa a la base de datos MySQL");
    console.log(`📊 Base de datos: ${process.env.DB_NAME || "proyecto_macrocell"}`);
  }
});

// Manejar errores de conexión
conexion.on('error', (err) => {
  console.error("❌ Error en la conexión de MySQL:", err);
  if (err.code === 'PROTOCOL_CONNECTION_LOST') {
    console.error("⚠️ Conexión perdida. Intentando reconectar...");
  } else {
    throw err;
  }
});

export default conexion;
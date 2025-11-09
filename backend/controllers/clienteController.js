import { conexion } from "../db.js";

// muestra todos los clientes
export const obtenerClientes = (req, res) => {
  conexion.query("SELECT * FROM cliente", (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

// registra un nuevo cliente
export const registrarCliente = (req, res) => {
  const { Nombre, Telefono, Correo } = req.body;
  const sql = "INSERT INTO cliente (Nombre, Telefono, Correo) VALUES (?, ?, ?)";
  conexion.query(sql, [Nombre, Telefono, Correo], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: "Cliente registrado correctamente" });
  });
};

//  se actuliza el cliente seleccionado
export const actualizarCliente = (req, res) => {
  const { id } = req.params;
  const { Nombre, Telefono, Correo } = req.body;
  const sql = "UPDATE cliente SET Nombre=?, Telefono=?, Correo=? WHERE ID_cliente=?";
  conexion.query(sql, [Nombre, Telefono, Correo, id], (err) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: "Cliente actualizado correctamente" });
  });
};

// elimina el cliente seleccionado
export const eliminarCliente = (req, res) => {
  const { id } = req.params;
  conexion.query("DELETE FROM cliente WHERE ID_cliente=?", [id], (err) => {
    if (err) return res.status(500).json({ error: err });
    res.json({ message: "Cliente eliminado correctamente" });
  });
};

import { conexion } from "../db.js";

// muestra todos los clientes
export const obtenerClientes = (req, res) => {
  conexion.query("SELECT * FROM cliente", (err, results) => {
    if (err) return res.status(500).json({ error: err });
    res.json(results);
  });
};

// obtener un cliente por id
export const obtenerClientePorId = (req, res) => {
  const { id } = req.params;
  conexion.query("SELECT * FROM cliente WHERE ID_cliente = ?", [id], (err, results) => {
    if (err) return res.status(500).json({ error: err });
    if (!results || results.length === 0) return res.status(404).json({ message: "Cliente no encontrado" });
    res.json(results[0]);
  });
};

// registra un nuevo cliente
export const registrarCliente = (req, res) => {
  const { Cedula, Nombre, Correo, Telefono, Direccion } = req.body;
  const sql = "INSERT INTO cliente (Cedula, Nombre, Correo, Telefono, Direccion) VALUES (?, ?, ?, ?, ?)";
  conexion.query(sql, [Cedula || null, Nombre, Correo || null, Telefono || null, Direccion || null], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    res.status(201).json({ message: "Cliente registrado correctamente", insertId: result.insertId });
  });
};

//  se actuliza el cliente seleccionado
export const actualizarCliente = (req, res) => {
  const { id } = req.params;
  const { Cedula, Nombre, Correo, Telefono, Direccion } = req.body;
  const sql = "UPDATE cliente SET Cedula=?, Nombre=?, Correo=?, Telefono=?, Direccion=? WHERE ID_cliente=?";
  conexion.query(sql, [Cedula || null, Nombre, Correo || null, Telefono || null, Direccion || null, id], (err) => {
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

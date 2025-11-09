// frontend/js/funciones.js
const API_URL = "http://localhost:3000/clientes";

const form = document.getElementById("formCliente");
const lista = document.getElementById("listaClientes");

// Cargar clientes
async function cargarClientes() {
  const res = await fetch(API_URL);
  const clientes = await res.json();
  lista.innerHTML = "";
  clientes.forEach((c) => {
    const li = document.createElement("li");
    li.innerHTML = `
      <b>${c.nombre}</b> - ${c.telefono} - ${c.correo}
      <button onclick="eliminarCliente(${c.id})">🗑️</button>
    `;
    lista.appendChild(li);
  });
}

// Agregar cliente
form.addEventListener("submit", async (e) => {
  e.preventDefault();
  const data = {
    nombre: document.getElementById("nombre").value,
    telefono: document.getElementById("telefono").value,
    correo: document.getElementById("correo").value,
  };

  await fetch(API_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });

  form.reset();
  cargarClientes();
});

// Eliminar cliente
async function eliminarCliente(id) {
  await fetch(`${API_URL}/${id}`, { method: "DELETE" });
  cargarClientes();
}

cargarClientes();

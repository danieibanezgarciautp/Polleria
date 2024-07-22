package com.polleriagordo.rest;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.*;

@Path("/productos")
public class ProductoResource {

    private static Map<Integer, String> productos = new HashMap<>();
    private static int currentId = 1;

    static {
        productos.put(currentId++, "Pollo a la brasa");
        productos.put(currentId++, "Salchipapas");
        productos.put(currentId++, "Chicha morada");
    }

    // Obtener la lista de productos
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response obtenerProductos() {
        List<String> listaProductos = new ArrayList<>(productos.values());
        return Response.ok(listaProductos).build();
    }

    // Obtener un producto específico por ID
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response obtenerProductoPorId(@PathParam("id") int id) {
        String producto = productos.get(id);
        if (producto == null) {
            return Response.status(Response.Status.NOT_FOUND).entity("Producto no encontrado").build();
        }
        return Response.ok(producto).build();
    }

    // Agregar un nuevo producto
    @POST
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response agregarProducto(String nombreProducto) {
        int id = currentId++;
        productos.put(id, nombreProducto);
        return Response.status(Response.Status.CREATED).entity("Producto agregado con ID: " + id).build();
    }

    // Actualizar un producto existente
    @PUT
    @Path("/{id}")
    @Consumes(MediaType.TEXT_PLAIN)
    @Produces(MediaType.APPLICATION_JSON)
    public Response actualizarProducto(@PathParam("id") int id, String nombreProducto) {
        if (!productos.containsKey(id)) {
            return Response.status(Response.Status.NOT_FOUND).entity("Producto no encontrado para actualizar").build();
        }
        productos.put(id, nombreProducto);
        return Response.ok("Producto actualizado").build();
    }

    // Eliminar un producto por ID
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response eliminarProducto(@PathParam("id") int id) {
        if (!productos.containsKey(id)) {
            return Response.status(Response.Status.NOT_FOUND).entity("Producto no encontrado para eliminar").build();
        }
        productos.remove(id);
        return Response.ok("Producto eliminado").build();
    }
}

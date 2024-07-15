<%@ page import="java.sql.*" %>
<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.*" %>
<%@ page import="java.io.*" %>

<%
response.setContentType("application/pdf");
response.setHeader("Content-Disposition", "attachment; filename=categorias_habitacion.pdf");

// Conexión a la base de datos
String url = "jdbc:mysql://localhost:3307/sigh_hoteldg";
String username = "root";
String password = "";
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

OutputStream outputStream = null; // Cambio de nombre de la variable

try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, username, password);

    // Consulta SQL para obtener datos de la tabla Categoriahabitacion
    String sql = "SELECT * FROM Producto";
    stmt = conn.prepareStatement(sql);
    rs = stmt.executeQuery();

    // Crear el documento PDF
    Document document = new Document();
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    PdfWriter.getInstance(document, baos);
    document.open();
    PdfPTable table = new PdfPTable(8);
    table.addCell("ID");
    table.addCell("Código de Producto");
    table.addCell("Nombre de Producto");
    table.addCell("Descripción");
    table.addCell("Tipo De Producto");
    table.addCell("Precio de Producto");
    table.addCell("Stock");
    table.addCell("Estado de Producto");

    // Llenar la tabla con los datos de la base de datos
    while (rs.next()) {
        table.addCell(rs.getString("idProducto"));
        table.addCell(rs.getString("CodProducto"));
        table.addCell(rs.getString("NombreProducto"));
        table.addCell(rs.getString("DescripcionProducto"));
        table.addCell(rs.getString("TipoProducto"));
        table.addCell(rs.getString("PrecioProducto"));
        table.addCell(rs.getString("Stock"));
        table.addCell(rs.getString("EstadoProducto"));
    }

    // Agregar la tabla al documento
    document.add(table);
    document.close();

    // Enviar el PDF generado como respuesta al cliente
    outputStream = response.getOutputStream(); // Cambio de nombre de la variable
    baos.writeTo(outputStream); // Cambio de nombre de la variable
    outputStream.flush(); // Cambio de nombre de la variable
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
        if (outputStream != null) outputStream.close(); // Cambio de nombre de la variable
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    }
}
%>
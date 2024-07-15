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
    String sql = "SELECT * FROM Cliente";
    stmt = conn.prepareStatement(sql);
    rs = stmt.executeQuery();

    // Crear el documento PDF
    Document document = new Document();
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    PdfWriter.getInstance(document, baos);
    document.open();
    PdfPTable table = new PdfPTable(8);
    table.addCell("ID");
    table.addCell("Tipo de Documento");
    table.addCell("N° Documento");
    table.addCell("Nombres");
    table.addCell("Apellido Paterno");
    table.addCell("Apellido Materno");
    table.addCell("Fecha de Nacimiento");
    table.addCell("Celular");

    // Llenar la tabla con los datos de la base de datos
    while (rs.next()) {
        table.addCell(rs.getString("idCliente"));
        table.addCell(rs.getString("tipodocumento"));
        table.addCell(rs.getString("Ndocumento"));
        table.addCell(rs.getString("Nombres"));
        table.addCell(rs.getString("ApellidoPaterno"));
        table.addCell(rs.getString("ApellidoMaterno"));
        table.addCell(rs.getString("FechaNacimiento"));
        table.addCell(rs.getString("Celular"));
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
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="cts.Configuration" %>
<%@ page import="cts.UserMasterPdfGenerator" %>
<%
Connection connection = null;

try {
       connection = Configuration.getConnection();

       if (connection == null) {
              throw new IllegalStateException("Unable to connect to the database");
       }

       InputStream logoStream = application.getResourceAsStream(
                     "/images/bank_logo.png");
       byte[] logoBytes = null;

       if (logoStream != null) {
              try (InputStream input = logoStream;
                      ByteArrayOutputStream logoOutput =
                                    new ByteArrayOutputStream()) {
                     byte[] buffer = new byte[4096];
                     int bytesRead;

                     while ((bytesRead = input.read(buffer)) != -1) {
                            logoOutput.write(buffer, 0, bytesRead);
                     }

                     logoBytes = logoOutput.toByteArray();
              }
       }

       String bankName = Configuration.getConfValByNm(
                     "CFG_BANKNAME",
                     connection);

       byte[] pdf = UserMasterPdfGenerator.generate(
                     connection,
                     logoBytes,
                     bankName);

       response.reset();
       response.setContentType("application/pdf");
       response.setHeader(
                     "Content-Disposition",
                     "attachment; filename=UserMasterReport.pdf");
       response.setContentLength(pdf.length);

       OutputStream output = response.getOutputStream();
       output.write(pdf);
       output.flush();

       out.clearBuffer();
} catch (Exception exception) {
       exception.printStackTrace();

       if (!response.isCommitted()) {
              response.sendError(
                            500,
                            "Unable to generate User Master Report");
       }
} finally {
       if (connection != null) {
              try {
                     connection.close();
              } catch (Exception ignored) {
              }
       }
}
%>
# E-Commerce Java Web Project

This project is a Java Servlet-based e-commerce web application.

## Build setup

The project is now configured with Maven so it can resolve the servlet and MySQL dependencies.

1. Install Maven locally.
2. Add the Maven `bin` directory to `PATH`.
3. Run:

```powershell
mvn package -DskipTests
```

## Run locally

Deploy the generated WAR to a Java Servlet container such as Tomcat.

## Notes

- Java source files are in the project root.
- MySQL connection details are set in `connection.java`.
- The app expects a local MySQL database named `itemdelivery`.

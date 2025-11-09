[![Github Actions CI/CD](https://github.com/vlademirjunior/RESTfulJava/actions/workflows/continuous-deployment.yml/badge.svg)](https://github.com/vlademirjunior/RESTfulJava/actions/workflows/continuous-deployment.yml)

# RESTfulJava API

This project implements a robust, secure, and modern **RESTful API** using **Java 21** and the **Spring Boot 3** ecosystem. The architecture strongly emphasizes advanced REST principles, utilizing **HATEOAS** and the **HAL (Hypertext Application Language)** format for resource linking. Security is managed by **Spring Security** using **JWT (JSON Web Tokens)**, and the API supports multi-content negotiation (JSON, XML, YAML).

The application includes features for CRUD operations, authentication, user management, advanced data processing (import/export), and email services. All integration tests rely on disposable environments managed by **Testcontainers**.

---

## Tools and Technologies

The following table details the key tools and libraries used in the project, highlighting their role in enforcing modern API standards:

| Tool/Library | Version | Usage Summary | Rationale for Use |
| :--- | :--- | :--- | :--- |
| **Java** | 21 | Core programming language. | Provides a robust, modern, and high-performance foundation. |
| **Spring Boot** | 3.4.1 | Simplifies dependency management and configuration. | Speeds up development and ensures dependency compatibility. |
| **Spring Data JPA** | N/A | **Used for database interaction via the ORM (Object-Relational Mapping) standard.** | **Facilitates the implementation of repository interfaces for easy and efficient data persistence.** |
| **Spring Security** | N/A | Provides comprehensive security services, configured for **stateless authentication**. | Essential for securing endpoints using industry standards. |
| **Java JWT** | 4.4.0 | Used by `JwtTokenProvider` to generate and validate **Access Tokens** and **Refresh Tokens**. | Implements stateless token-based authorization using **JWT**. |
| **Spring Hateoas** | N/A | Enables the implementation of **HATEOAS** links embedded in DTOs (e.g., `PersonDTO`), adhering to the **HAL** standard for resource representation. | Crucial for designing a Level 3 REST API, improving resource discoverability. |
| **Spring Mail** | N/A | **Handles the sending of emails, supporting attachments and simple email composition.** | **Provides an abstract layer for email services, necessary for the `/api/email/v1` features.** |
| **Springdoc OpenAPI Starter WebMVC UI** | 1.20.4 | Integrates **OpenAPI (Swagger)** documentation. Endpoints are documented using annotations. | Provides accessible, interactive documentation (**Swagger UI**) for API consumers. |
| **Jackson Dataformat XML/YAML** | N/A | Extends Jackson to handle **XML** and **YAML** payloads via custom converters (`YamlJackson2HttpMessageConverter`). | Enables flexible multi-content negotiation, serving JSON, XML, and YAML based on client `Accept` headers. |
| **Testcontainers** | 1.20.4 | Used to spin up a disposable **PostgreSQL 15.10** container for environment isolation during integration tests. | Guarantees reliable, reproducible testing by ensuring a clean database environment for every test run. |
| **Jasper Reports** | 7.0.1 | Utilized for generating rich, complex data export in **PDF** format (e.g., specific person reports **including QR codes with Google zxing**). | Supports professional, formatted reporting capabilities. |
| **Apache POI OOXML** | 5.3.0 | Facilitates massive data import and page export in **XLSX** format. | Provides interoperability with standard spreadsheet applications. |
| **Commons CSV** | 1.12.0 | Used for reading and writing data in **CSV** format for mass operations. | Supports simple, text-based bulk data exchange. |

---

## API Endpoints Reference

All application endpoints are versioned under `/v1`. Authentication endpoints are accessed via `/auth`.

| Endpoint Path | Method | Parameters | Consumes / Produces | Description |
| :--- | :--- | :--- | :--- | :--- |
| **Authentication & Users** | | | | |
| `/auth/signin` | `POST` | Body: `AccountCredentialsDTO` | JSON, XML, YAML | Authenticates user credentials and issues a **JWT** `TokenDTO` (Access and Refresh). |
| `/auth/refresh/{username}` | `PUT` | Path: `username`; Header: `Authorization` (Refresh Token) | JSON, XML, YAML | Refreshes the access token using a valid refresh token. |
| `/auth/createUser` | `POST` | Body: `AccountCredentialsDTO` (username, password, fullname) | JSON, XML, YAML | Registers a new user account in the system. |
| **People Management (`/api/person/v1`)** | | | | |
| `/api/person/v1` | `GET` | Query: `page`, `size`, `direction` (asc/desc) | JSON, XML, YAML | Retrieves a paginated and sorted list of people, including **HATEOAS/HAL** links. |
| `/api/person/v1/{id}` | `GET` | Path: `id` | JSON, XML, YAML | Finds a specific person by ID, returning **HATEOAS** links. |
| `/api/person/v1` | `POST` | Body: `PersonDTO` | JSON, XML, YAML | Adds a new person. |
| `/api/person/v1` | `PUT` | Body: `PersonDTO` | JSON, XML, YAML | Updates an existing person. |
| `/api/person/v1/{id}` | `PATCH` | Path: `id` | JSON, XML, YAML | **Disables** a specific person record (soft delete). |
| `/api/person/v1/{id}` | `DELETE` | Path: `id` | N/A | Hard deletes a specific person record. |
| `/api/person/v1/findPeopleByName/{firstName}` | `GET` | Path: `firstName`; Query: `page`, `size`, `direction` | JSON, XML, YAML | Finds people matching the given first name, supporting pagination. |
| `/api/person/v1/massCreation` | `POST` | RequestParam: `file` (MultipartFile) | `multipart/form-data` | Massive creation of records by importing data from uploaded **XLSX or CSV** files. |
| `/api/person/v1/exportPage` | `GET` | Query: `page`, `size`, `direction`; Header: `Accept` | XLSX, CSV, PDF | Exports a paginated set of people data into the requested format (XLSX, CSV, or PDF). |
| `/api/person/v1/export/{id}` | `GET` | Path: `id`; Header: `Accept: application/pdf` | PDF | Exports data for a specific person as a detailed PDF report. |
| **Book Management (`/api/book/v1`)** | | | | |
| `/api/book/v1` | `GET` | Query: `page`, `size`, `direction` (sorted by `title`) | JSON, XML, YAML | Retrieves a paginated and sorted list of all books, including **HATEOAS/HAL** links. |
| `/api/book/v1/{id}` | `GET` | Path: `id` | JSON, XML, YAML | Finds a specific book by its ID. |
| `/api/book/v1` | `POST` | Body: `BookDTO` | JSON, XML, YAML | Adds a new book. |
| `/api/book/v1` | `PUT` | Body: `BookDTO` | JSON, XML, YAML | Updates an existing book. |
| `/api/book/v1/{id}` | `DELETE` | Path: `id` | N/A | Deletes a specific book record. |
| **File Handling (`/api/file/v1`)** | | | | |
| `/api/file/v1/uploadFile` | `POST` | RequestParam: `file` (MultipartFile) | `multipart/form-data` | Uploads a single file. |
| `/api/file/v1/uploadMultipleFiles` | `POST` | RequestParam: `files` (MultipartFile[]) | `multipart/form-data` | Uploads multiple files simultaneously. |
| `/api/file/v1/downloadFile/{fileName}` | `GET` | Path: `fileName` | `application/octet-stream` | Downloads the specified file. |
| **Email Service (`/api/email/v1`)** | | | | |
| `/api/email/v1` | `POST` | Body: `EmailRequestDTO` | JSON, XML, YAML | Sends a simple email. |
| `/api/email/v1/withAttachment` | `POST` | RequestParam: `emailRequest` (JSON String), `attachment` (MultipartFile) | `multipart/form-data` | Sends an email that includes a file attachment. |
| **Test Endpoint** | | | | |
| `/api/test/v1` | `GET` | N/A | String | Endpoint used to generate DEBUG, INFO, WARN, and ERROR logs. |

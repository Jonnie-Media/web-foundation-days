# Library Books REST API

## 1. Overview

The Library Books API allows users to view, search, create, update, and delete books in a library.

**Base URL:** `/api/v1`

**Resource:** `/books`

### Book data structure

Each book contains the following fields:

- `id` — unique identifier for the book.
- `title` — title of the book.
- `author` — name of the book's author.
- `publishedYear` — year the book was published.
- `isbn` — International Standard Book Number.

Example book object:

```json
{
  "id": 1,
  "title": "Things Fall Apart",
  "author": "Chinua Achebe",
  "publishedYear": 1958,
  "isbn": "9780385474542"
}
```

## 2. API Endpoints

### Endpoint 1: List all books

- **Method:** GET
- **Path:** `/api/v1/books`
- **Description:** Retrieves all books in the library.
- **Request body:** Not required.
- **Success status:** `200 OK`

Example response:

```json
[
  {
    "id": 1,
    "title": "Things Fall Apart",
    "author": "Chinua Achebe",
    "publishedYear": 1958,
    "isbn": "9780385474542"
  }
]
```

### Endpoint 2: Get one book

- **Method:** GET
- **Path:** `/api/v1/books/{id}`
- **Description:** Retrieves a single book using its unique ID.
- **Request body:** Not required.
- **Success status:** `200 OK`

Example request:

`GET /api/v1/books/1`

Example response:

```json
{
  "id": 1,
  "title": "Things Fall Apart",
  "author": "Chinua Achebe",
  "publishedYear": 1958,
  "isbn": "9780385474542"
}
```

### Endpoint 3: Create a book

- **Method:** POST
- **Path:** `/api/v1/books`
- **Description:** Adds a new book to the library.
- **Request body:** Required.
- **Success status:** `201 Created`

Example request body:

```json
{
  "title": "The River Between",
  "author": "Ngugi wa Thiong'o",
  "publishedYear": 1965,
  "isbn": "9780435905484"
}
```

Example response:

```json
{
  "id": 2,
  "title": "The River Between",
  "author": "Ngugi wa Thiong'o",
  "publishedYear": 1965,
  "isbn": "9780435905484"
}
```

### Endpoint 4: Update a book

- **Method:** PUT
- **Path:** `/api/v1/books/{id}`
- **Description:** Replaces the editable details of an existing book.
- **Request body:** Required; includes the complete set of editable book fields.
- **Success status:** `200 OK`

Example request:

`PUT /api/v1/books/1`

Example request body:

```json
{
  "title": "Things Fall Apart - Revised Edition",
  "author": "Chinua Achebe",
  "publishedYear": 1958,
  "isbn": "9780385474542"
}
```

Example response:

```json
{
  "id": 1,
  "title": "Things Fall Apart - Revised Edition",
  "author": "Chinua Achebe",
  "publishedYear": 1958,
  "isbn": "9780385474542"
}
```

### Endpoint 5: Delete a book

- **Method:** DELETE
- **Path:** `/api/v1/books/{id}`
- **Description:** Removes a book from the library.
- **Request body:** Not required.
- **Success status:** `204 No Content`

Example request:

`DELETE /api/v1/books/1`

Example response: No response body is returned.

### Endpoint 6: List books by author

- **Method:** GET
- **Path:** `/api/v1/books?author={authorName}`
- **Description:** Retrieves books written by a specified author.
- **Request body:** Not required.
- **Success status:** `200 OK`

Example request:

`GET /api/v1/books?author=Chinua%20Achebe`

Example response:

```json
[
  {
    "id": 1,
    "title": "Things Fall Apart",
    "author": "Chinua Achebe",
    "publishedYear": 1958,
    "isbn": "9780385474542"
  }
]
```

The author search should be case-insensitive. If no books match the author, the API should return `200 OK` with an empty array.

## 3. Error Responses

### Error 400: Bad Request

**Meaning:** The server cannot process the request because the input is invalid.

Example situations:

- A required book title or author is missing.
- The published year is not a valid number.
- A request contains invalid JSON.

Example response:

```json
{
  "error": "Bad Request",
  "message": "The book title and author are required."
}
```

### Error 404: Not Found

**Meaning:** The requested resource does not exist.

Example situations:

- A client requests `/api/v1/books/999`, but book 999 does not exist.
- A client attempts to update or delete a nonexistent book.

Example response:

```json
{
  "error": "Not Found",
  "message": "The requested book was not found."
}
```

## 4. Summary Table

| Method | Endpoint | Purpose | Success status |
|---|---|---|---|
| GET | `/api/v1/books` | List all books | 200 OK |
| GET | `/api/v1/books/{id}` | Get one book | 200 OK |
| POST | `/api/v1/books` | Create a book | 201 Created |
| PUT | `/api/v1/books/{id}` | Update a book | 200 OK |
| DELETE | `/api/v1/books/{id}` | Delete a book | 204 No Content |
| GET | `/api/v1/books?author={authorName}` | List books by author | 200 OK |

## 5. Conclusion

This API uses REST conventions and HTTP methods to manage library books. It returns suitable success status codes when requests are successful and uses `400 Bad Request` and `404 Not Found` to describe common client errors.
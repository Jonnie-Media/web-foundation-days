```javascript
const loadButton = document.getElementById("load-users");
const filterInput = document.getElementById("filter-input");
const status = document.getElementById("status");
const usersList = document.getElementById("users-list");

const API_URL = "https://jsonplaceholder.typicode.com/users";

// Store all loaded users here.
let users = [];

// Display an array of users on the page.
function renderUsers(userArray) {
    // Remove previously displayed users.
    usersList.replaceChildren();

    if (userArray.length === 0) {
        const message = document.createElement("li");
        message.textContent = "No users match your filter.";
        usersList.appendChild(message);
        return;
    }

    userArray.forEach((user) => {
        const listItem = document.createElement("li");

        const name = document.createElement("h3");
        name.textContent = user.name;

        const email = document.createElement("p");
        email.textContent = `Email: ${user.email}`;

        const city = document.createElement("p");
        city.textContent = `City: ${user.address.city}`;

        const company = document.createElement("p");
        company.textContent = `Company: ${user.company.name}`;

        listItem.append(name, email, city, company);
        usersList.appendChild(listItem);
    });
}

// Fetch users from the API.
async function loadUsers() {
    loadButton.disabled = true;
    status.textContent = "Loading users...";
    usersList.replaceChildren();

    try {
        const response = await fetch(API_URL);

        // fetch does not automatically reject HTTP errors.
        if (!response.ok) {
            throw new Error(`HTTP error: ${response.status}`);
        }

        const data = await response.json();

        // Store the results in the global array.
        users = data;

        // Apply any existing filter.
        const searchText = filterInput.value.trim().toLowerCase();

        const filteredUsers = users.filter((user) =>
            user.name.toLowerCase().includes(searchText)
        );

        renderUsers(filteredUsers);
        status.textContent = `Successfully loaded ${users.length} users.`;

    } catch (error) {
        users = [];
        usersList.replaceChildren();
        status.textContent = `Error loading users: ${error.message}`;

    } finally {
        // Always re-enable the button.
        loadButton.disabled = false;
    }
}

// Load users when the button is clicked.
loadButton.addEventListener("click", loadUsers);

// Filter the stored array without sending another request.
filterInput.addEventListener("input", () => {
    const searchText = filterInput.value.trim().toLowerCase();

    const filteredUsers = users.filter((user) =>
        user.name.toLowerCase().includes(searchText)
    );

    renderUsers(filteredUsers);
});
```
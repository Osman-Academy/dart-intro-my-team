const MOCK_USERS = [
    { id: 1, username: 'customer', password: 'password', email: 'customer@example.com', role: 'customer' },
    { id: 2, username: 'admin', password: 'admin', email: 'admin@example.com', role: 'admin' },
];

async function loginUser(username, password) {
    const user = MOCK_USERS.find(u => u.username === username && u.password === password);

    if (user) {
        const mockToken = `mock_jwt_token_for_${user.username}`;
        localStorage.setItem('jwt_token', mockToken);
        localStorage.setItem('user_id', user.id);
        localStorage.setItem('username', user.username);
        localStorage.setItem('user_role', user.role);
        return { success: true, user: { id: user.id, username: user.username, role: user.role } };
    } else {
        return { success: false, message: 'Invalid username or password.' };
    }
}

async function registerUser(username, password, email) {
    if (MOCK_USERS.some(u => u.username === username)) {
        return { success: false, message: 'User with this username already exists.' };
    }
    if (MOCK_USERS.some(u => u.email === email)) {
        return { success: false, message: 'User with this email already exists.' };
    }

    const newUser = {
        id: MOCK_USERS.length + 1,
        username,
        password,
        email,
        role: 'customer'
    };
    MOCK_USERS.push(newUser);
    return { success: true, user: newUser };
}

function logoutUser() {
    localStorage.removeItem('jwt_token');
    localStorage.removeItem('user_id');
    localStorage.removeItem('username');
    localStorage.removeItem('user_role');
    window.location.href = '/index.html';
}

function isAuthenticated() {
    return localStorage.getItem('jwt_token') !== null;
}

function getUserRole() {
    return localStorage.getItem('user_role');
}

function getUserId() {
    return localStorage.getItem('user_id');
}

function redirectToDashboard() {
    if (isAuthenticated()) {
        const role = getUserRole();
        if (role === 'admin') {
            window.location.href = '/admin_dashboard.html';
        } else if (role === 'customer') {
            window.location.href = '/customer_dashboard.html';
        } else {
            alert('Unknown user role. Redirecting to home.');
            logoutUser();
        }
    } else {
        window.location.href = '/index.html';
    }
}

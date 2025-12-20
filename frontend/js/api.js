const BASE_URL = 'http://localhost:8080/api/v1';

async function request(url, method = 'GET', data = null, authRequired = false) {
    const headers = {
        'Content-Type': 'application/json',
    };

    if (authRequired) {
        const token = localStorage.getItem('jwt_token');
        if (token) {
            headers['Authorization'] = `Bearer ${token}`;
        } else {
            throw new Error('Authentication required, but no token found.');
        }
    }

    const config = {
        method: method,
        headers: headers,
    };

    if (data) {
        config.body = JSON.stringify(data);
    }

    try {
        const response = await fetch(`${BASE_URL}${url}`, config);

        if (response.ok) {
            if (response.status === 204) {
                return null;
            }
            return await response.json();
        } else {
            const errorData = await response.json();
            throw new Error(errorData.message || `HTTP error! Status: ${response.status}`);
        }
    } catch (error) {
        console.error('API Request Error:', error);
        throw error;
    }
}

const categoriesApi = {
    getAll: () => request('/categories', 'GET'),
    getById: (id) => request(`/categories/${id}`, 'GET'),
    create: (categoryDto) => request('/categories', 'POST', categoryDto, true),
    update: (id, categoryDto) => request(`/categories/${id}`, 'PUT', categoryDto, true),
    delete: (id) => request(`/categories/${id}`, 'DELETE', null, true),
};

const productsApi = {
    getAll: () => request('/products', 'GET'),
    getById: (id) => request(`/products/${id}`, 'GET'),
    create: (productDto) => request('/products', 'POST', productDto, true),
    update: (id, productDto) => request(`/products/${id}`, 'PUT', productDto, true),
    delete: (id) => request(`/products/${id}`, 'DELETE', null, true),
};

const usersApi = {
    getAll: () => request('/users', 'GET', null, true),
    getById: (id) => request(`/users/${id}`, 'GET', null, true),
    create: (userRequestDto) => request('/users', 'POST', userRequestDto),
    update: (id, userRequestDto) => request(`/users/${id}`, 'PUT', userRequestDto, true),
    delete: (id) => request(`/users/${id}`, 'DELETE', null, true),
};

const ordersApi = {
    getAll: () => request('/orders', 'GET', null, true),
    getById: (id) => request(`/orders/${id}`, 'GET', null, true),
    create: (orderDto) => request('/orders', 'POST', orderDto, true),
    update: (id, orderDto) => request(`/orders/${id}`, 'PUT', orderDto, true),
    delete: (id) => request(`/orders/${id}`, 'DELETE', null, true),
};

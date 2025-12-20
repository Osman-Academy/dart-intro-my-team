document.addEventListener('DOMContentLoaded', () => {
    if (!isAuthenticated() || getUserRole() !== 'admin') {
        alert('Access denied. Please login as an administrator.');
        window.location.href = '/login.html';
        return;
    }

    const welcomeMessage = document.getElementById('welcome-message');
    const ordersListElement = document.getElementById('orders-list');
    const productForm = document.getElementById('product-form');
    const productsManagementList = document.getElementById('products-management-list');
    const logoutButton = document.getElementById('logout-button');
    const categorySelect = document.getElementById('product-category');

    welcomeMessage.textContent = `Welcome, Administrator ${localStorage.getItem('username')}!`;

    async function loadOrders() {
        try {
            const orders = await ordersApi.getAll();
            ordersListElement.innerHTML = '';
            if (orders.length === 0) {
                ordersListElement.innerHTML = '<p>No orders to process.</p>';
                return;
            }
            orders.forEach(order => {
                const orderCard = document.createElement('div');
                orderCard.className = 'order-card';
                orderCard.innerHTML = `
                    <h4>Order #${order.id}</h4>
                    <p><strong>User ID:</strong> ${order.userId}</p>
                    <p><strong>Status:</strong> ${order.status}</p>
                    <p><strong>Total:</strong> ${order.totalAmount.toFixed(2)} USD</p>
                    <p><strong>Date:</strong> ${new Date(order.createdAt).toLocaleString()}</p>
                    <h5>Items:</h5>
                    <ul class="order-items-list">
                        ${order.items.map(item => `<li>${item.name || 'Product ID ' + item.productId} x ${item.quantity} (${item.priceAtPurchase.toFixed(2)} USD)</li>`).join('')}
                    </ul>
                    <div class="order-actions">
                        <button class="btn btn-primary complete-order-btn" data-order-id="${order.id}" ${order.status === 'DELIVERED' ? 'disabled' : ''}>Complete</button>
                        <button class="btn btn-warning cancel-order-btn" data-order-id="${order.id}" ${order.status === 'DELIVERED' || order.status === 'CANCELLED' ? 'disabled' : ''}>Cancel</button>
                    </div>
                `;
                ordersListElement.appendChild(orderCard);
            });

            document.querySelectorAll('.complete-order-btn').forEach(button => {
                button.addEventListener('click', async (event) => {
                    const orderId = event.target.dataset.orderId;
                    try {
                        await ordersApi.update(orderId, { status: 'DELIVERED' });
                        alert(`Order #${orderId} completed.`);
                        loadOrders();
                    } catch (error) {
                        console.error('Error completing order:', error);
                        alert('Error completing order: ' + error.message);
                    }
                });
            });

            document.querySelectorAll('.cancel-order-btn').forEach(button => {
                button.addEventListener('click', async (event) => {
                    const orderId = event.target.dataset.orderId;
                    try {
                        await ordersApi.update(orderId, { status: 'CANCELLED' });
                        alert(`Order #${orderId} cancelled.`);
                        loadOrders();
                    } catch (error) {
                        console.error('Error cancelling order:', error);
                        alert('Error cancelling order: ' + error.message);
                    }
                });
            });

        } catch (error) {
            console.error('Error loading orders:', error);
            ordersListElement.innerHTML = '<p class="message error">Failed to load orders.</p>';
        }
    }

    async function loadCategoriesForSelect() {
        try {
            const categories = await categoriesApi.getAll();
            categorySelect.innerHTML = '<option value="">Select Category</option>';
            categories.forEach(category => {
                const option = document.createElement('option');
                option.value = category.id;
                option.textContent = category.name;
                categorySelect.appendChild(option);
            });
        } catch (error) {
            console.error('Error loading categories:', error);
            alert('Failed to load categories for product form.');
        }
    }

    async function loadProductsForManagement() {
        try {
            const products = await productsApi.getAll();
            productsManagementList.innerHTML = '';
            if (products.length === 0) {
                productsManagementList.innerHTML = '<p>No products in the system.</p>';
                return;
            }
            products.forEach(product => {
                const productCard = document.createElement('div');
                productCard.className = 'admin-product-card';
                productCard.innerHTML = `
                    <h4>${product.name} (ID: ${product.id})</h4>
                    <p><strong>Price:</strong> ${product.price.toFixed(2)} USD</p>
                    <p><strong>Status:</strong> ${product.status}</p>
                    <p><strong>Category ID:</strong> ${product.categoryId || 'N/A'}</p>
                    <div class="product-actions">
                        <button class="btn btn-info edit-product-btn" data-product-id="${product.id}">Edit</button>
                        <button class="btn btn-danger delete-product-btn" data-product-id="${product.id}">Delete</button>
                    </div>
                `;
                productsManagementList.appendChild(productCard);
            });

            document.querySelectorAll('.edit-product-btn').forEach(button => {
                button.addEventListener('click', async (event) => {
                    const productId = event.target.dataset.productId;
                    alert(`Edit product ID: ${productId}`);
                });
            });

            document.querySelectorAll('.delete-product-btn').forEach(button => {
                button.addEventListener('click', async (event) => {
                    const productId = event.target.dataset.productId;
                    if (confirm(`Are you sure you want to delete product ID: ${productId}?`)) {
                        try {
                            await productsApi.delete(productId);
                            alert(`Product ID: ${productId} deleted.`);
                            loadProductsForManagement();
                        } catch (error) {
                            console.error('Error deleting product:', error);
                            alert('Error deleting product: ' + error.message);
                        }
                    }
                });
            });

        } catch (error) {
            console.error('Error loading products for management:', error);
            productsManagementList.innerHTML = '<p class="message error">Failed to load products for management.</p>';
        }
    }

    productForm.addEventListener('submit', async (event) => {
        event.preventDefault();
        const productId = document.getElementById('product-id').value;
        const productData = {
            name: document.getElementById('product-name').value,
            description: document.getElementById('product-description').value,
            price: parseFloat(document.getElementById('product-price').value),
            status: document.getElementById('product-status').value,
            imageUrl: document.getElementById('product-image-url').value,
            categoryId: document.getElementById('product-category').value ? parseInt(document.getElementById('product-category').value) : null
        };

        try {
            if (productId) {
                await productsApi.update(productId, productData);
                alert('Product updated successfully!');
            } else {
                await productsApi.create(productData);
                alert('Product added successfully!');
            }
            productForm.reset();
            document.getElementById('product-id').value = '';
            loadProductsForManagement();
        } catch (error) {
            console.error('Error saving product:', error);
            alert('Error saving product: ' + error.message);
        }
    });

    logoutButton.addEventListener('click', logoutUser);

    loadOrders();
    loadCategoriesForSelect();
    loadProductsForManagement();
});

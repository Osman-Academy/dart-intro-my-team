document.addEventListener('DOMContentLoaded', () => {
    const productListElement = document.getElementById('product-list');
    const authButtons = document.getElementById('auth-buttons');
    const userGreeting = document.getElementById('user-greeting');
    const logoutButton = document.getElementById('logout-button');
    const customerDashboardLink = document.getElementById('customer-dashboard-link');
    const adminDashboardLink = document.getElementById('admin-dashboard-link');

    function updateAuthUI() {
        if (isAuthenticated()) {
            authButtons.classList.add('hidden');
            userGreeting.classList.remove('hidden');
            logoutButton.classList.remove('hidden');
            userGreeting.textContent = `Hello, ${localStorage.getItem('username')}!`;

            const role = getUserRole();
            if (role === 'customer') {
                customerDashboardLink.classList.remove('hidden');
                adminDashboardLink.classList.add('hidden');
            } else if (role === 'admin') {
                adminDashboardLink.classList.remove('hidden');
                customerDashboardLink.classList.add('hidden');
            }
        } else {
            authButtons.classList.remove('hidden');
            userGreeting.classList.add('hidden');
            logoutButton.classList.add('hidden');
            customerDashboardLink.classList.add('hidden');
            adminDashboardLink.classList.add('hidden');
        }
    }

    async function loadProducts() {
        try {
            const products = await productsApi.getAll();
            productListElement.innerHTML = '';
            products.forEach(product => {
                const productCard = document.createElement('div');
                productCard.className = 'product-card';
                productCard.innerHTML = `
                    <img src="${product.imageUrl || 'https://via.placeholder.com/200x200?text=No+Image'}" alt="${product.name}">
                    <div class="product-card-content">
                        <h3>${product.name}</h3>
                        <p>${product.description}</p>
                        <p><strong>Status:</strong> ${product.status}</p>
                        <p class="price">${product.price} USD</p>
                        <div class="actions">
                            <button class="btn btn-primary add-to-cart-btn" data-product-id="${product.id}" data-product-name="${product.name}" data-product-price="${product.price}">Add to Cart</button>
                        </div>
                    </div>
                `;
                productListElement.appendChild(productCard);
            });

            document.querySelectorAll('.add-to-cart-btn').forEach(button => {
                button.addEventListener('click', (event) => {
                    if (!isAuthenticated() || getUserRole() !== 'customer') {
                        alert('Please log in as a customer to add items to the cart.');
                        return;
                    }
                    const productId = event.target.dataset.productId;
                    const productName = event.target.dataset.productName;
                    const productPrice = parseFloat(event.target.dataset.productPrice);
                    cart.addItem({ id: productId, name: productName, price: productPrice, quantity: 1 });
                    alert(`${productName} added to cart!`);
                });
            });

        } catch (error) {
            console.error('Error loading products:', error);
            productListElement.innerHTML = '<p class="message error">Failed to load products. Please try again later.</p>';
        }
    }

    updateAuthUI();
    loadProducts();

    logoutButton.addEventListener('click', logoutUser);
});

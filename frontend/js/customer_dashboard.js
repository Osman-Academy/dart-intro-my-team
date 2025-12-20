document.addEventListener('DOMContentLoaded', () => {
    if (!isAuthenticated() || getUserRole() !== 'customer') {
        alert('Access denied. Please login as a customer.');
        window.location.href = '/login.html';
        return;
    }

    const welcomeMessage = document.getElementById('welcome-message');
    const cartItemsContainer = document.getElementById('cart-items');
    const cartTotalElement = document.getElementById('cart-total');
    const checkoutButton = document.getElementById('checkout-button');
    const logoutButton = document.getElementById('logout-button');

    welcomeMessage.textContent = `Welcome, ${localStorage.getItem('username')}!`;

    function renderCart() {
        cartItemsContainer.innerHTML = '';
        const items = cart.getCartItems();
        if (items.length === 0) {
            cartItemsContainer.innerHTML = '<p>Your cart is empty.</p>';
            cartTotalElement.textContent = '0.00 USD';
            checkoutButton.disabled = true;
            return;
        }

        items.forEach(item => {
            const cartItemElement = document.createElement('div');
            cartItemElement.className = 'cart-item';
            cartItemElement.innerHTML = `
                <div class="cart-item-info">
                    <h4>${item.name}</h4>
                    <p>${item.price} USD x ${item.quantity}</p>
                </div>
                <div class="cart-item-actions">
                    <button class="btn btn-info btn-sm" data-product-id="${item.id}" data-action="decrease">-</button>
                    <span>${item.quantity}</span>
                    <button class="btn btn-info btn-sm" data-product-id="${item.id}" data-action="increase">+</button>
                    <button class="btn btn-danger btn-sm" data-product-id="${item.id}" data-action="remove">Remove</button>
                </div>
            `;
            cartItemsContainer.appendChild(cartItemElement);
        });

        cartTotalElement.textContent = `${cart.getTotal().toFixed(2)} USD`;
        checkoutButton.disabled = false;
    }

    cartItemsContainer.addEventListener('click', (event) => {
        const target = event.target;
        const productId = target.dataset.productId;
        const action = target.dataset.action;

        if (!productId) return;

        let item = cart.getCartItems().find(i => i.id === productId);
        if (!item) return;

        if (action === 'increase') {
            cart.updateItemQuantity(productId, item.quantity + 1);
        } else if (action === 'decrease') {
            cart.updateItemQuantity(productId, item.quantity - 1);
        } else if (action === 'remove') {
            cart.removeItem(productId);
        }
        renderCart();
    });

    checkoutButton.addEventListener('click', async () => {
        const cartItems = cart.getCartItems();
        if (cartItems.length === 0) {
            alert('Your cart is empty!');
            return;
        }

        const userId = getUserId();
        const orderItemsDto = cartItems.map(item => ({
            productId: item.id,
            quantity: item.quantity,
            priceAtPurchase: item.price
        }));

        const orderDto = {
            userId: userId,
            status: 'NEW',
            totalAmount: cart.getTotal(),
            items: orderItemsDto
        };

        try {
            const createdOrder = await ordersApi.create(orderDto);
            alert(`Order #${createdOrder.id} placed successfully!`);
            cart.clearCart();
            renderCart();
        } catch (error) {
            console.error('Error placing order:', error);
            alert('Error placing order: ' + error.message);
        }
    });

    logoutButton.addEventListener('click', logoutUser);

    renderCart();
});

const cart = {
    items: [],

    loadCart() {
        const storedCart = localStorage.getItem('cart');
        if (storedCart) {
            this.items = JSON.parse(storedCart);
        }
    },

    saveCart() {
        localStorage.setItem('cart', JSON.stringify(this.items));
    },

    addItem(product) {
        const existingItem = this.items.find(item => item.id === product.id);
        if (existingItem) {
            existingItem.quantity += product.quantity || 1;
        } else {
            this.items.push({ ...product, quantity: product.quantity || 1 });
        }
        this.saveCart();
    },

    removeItem(productId) {
        this.items = this.items.filter(item => item.id !== productId);
        this.saveCart();
    },

    updateItemQuantity(productId, quantity) {
        const item = this.items.find(item => item.id === productId);
        if (item) {
            item.quantity = quantity;
            if (item.quantity <= 0) {
                this.removeItem(productId);
            }
            this.saveCart();
        }
    },

    clearCart() {
        this.items = [];
        this.saveCart();
    },

    getCartItems() {
        return this.items;
    },

    getTotal() {
        return this.items.reduce((total, item) => total + (item.price * item.quantity), 0);
    }
};

cart.loadCart();

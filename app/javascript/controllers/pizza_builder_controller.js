import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 1. Targets: Elementos del DOM que Stimulus debe observar
  static targets = [
    "baseSelection",
    "ingredientSelection",
    "pizzaVisualArea",
    "totalPriceDisplay",
    "orderButton",
    // NUEVOS TARGETS PARA EL TAMAÑO
    "sizeSelection", "sizeOption" 
  ]
  
  // 2. Valores: Almacenamiento de estado
  static values = {
    selectedBaseId: Number,
    selectedIngredients: Array,
    basePrice: Number, // Ahora es solo el precio base (Masa)
    totalPrice: Number,
    // NUEVOS VALUES PARA EL TAMAÑO
    selectedSizeName: String, 
    selectedSizePrice: Number // Precio adicional por el tamaño
  }
  
  connect() {
    this.selectedIngredientsValue = []
    this.totalPriceValue = 0.0
    this.basePriceValue = 0.0
    this.selectedSizeNameValue = "" // Inicializar el nombre del tamaño
    this.selectedSizePriceValue = 0.0 // Inicializar el precio del tamaño
    console.log("Controlador PizzaBuilder conectado.")
    this.updateTotalPriceDisplay()
  }

  // --- Métodos de Interacción ---

  // NUEVO MÉTODO PARA SELECCIONAR TAMAÑO
  selectSize(event) {
    const selectedSizeElement = event.currentTarget;
    const sizeName = selectedSizeElement.dataset.sizeName;
    const sizePrice = parseFloat(selectedSizeElement.dataset.sizePrice);
    
    // 1. Resetear el resaltado
    this.sizeOptionTargets.forEach(el => {
      el.classList.remove('bg-green-100', 'border-2', 'border-green-500');
    });
    
    // 2. Aplicar el resaltado al elemento seleccionado
    selectedSizeElement.classList.add('bg-green-100', 'border-2', 'border-green-500');
    
    // 3. Actualizar los values de Stimulus
    this.selectedSizeNameValue = sizeName;
    this.selectedSizePriceValue = sizePrice;
    
    // 4. Recalcular el precio total
    this.calculateTotal(); 
  }
  // FIN: NUEVO MÉTODO

  selectBase(event) {
    const baseElement = event.currentTarget;
    const baseId = parseInt(baseElement.dataset.baseId);
    const basePrice = parseFloat(baseElement.dataset.basePrice);
    const imageUrl = baseElement.dataset.imageUrl;

    if (this.selectedBaseIdValue === baseId) {
      // Si la base ya está seleccionada, deseleccionarla
      this.selectedBaseIdValue = null;
      this.basePriceValue = 0.0;
    } else {
      // Seleccionar nueva base
      this.selectedBaseIdValue = baseId;
      this.basePriceValue = basePrice;
      this.updatePizzaVisual('base', imageUrl, baseId);
    }
    
    this.highlightBaseSelection(baseElement);
    this.calculateTotal();
  }

  toggleIngredient(event) {
    // ... (Lógica de toggleIngredient se mantiene igual)
    const ingredientElement = event.currentTarget;
    const ingredientId = parseInt(ingredientElement.dataset.ingredientId);
    const ingredientPrice = parseFloat(ingredientElement.dataset.ingredientPrice);
    const imageUrl = ingredientElement.dataset.imageUrl;

    let ingredients = this.selectedIngredientsValue;
    const index = ingredients.indexOf(ingredientId);

    if (index > -1) {
      // Quitar ingrediente
      ingredients.splice(index, 1);
      this.removePizzaVisual('ingredient', ingredientId);
    } else {
      // Añadir ingrediente
      ingredients.push(ingredientId);
      this.updatePizzaVisual('ingredient', imageUrl, ingredientId);
    }
    
    this.selectedIngredientsValue = ingredients;
    this.highlightIngredientSelection(ingredientElement);
    this.calculateTotal();
  }

  // --- Métodos de Visualización y Lógica ---

  updatePizzaVisual(type, imageUrl, id) {
    // ... (updatePizzaVisual se mantiene igual)
    // 1. Limpia el área visual si es la primera base
    if (type === 'base') {
      this.pizzaVisualAreaTarget.innerHTML = '';
      this.pizzaVisualAreaTarget.style.backgroundImage = `url(/assets/${imageUrl})`;
      this.pizzaVisualAreaTarget.style.backgroundSize = 'cover';
      this.pizzaVisualAreaTarget.style.backgroundPosition = 'center';
    } else if (type === 'ingredient') {
      // 2. Añade una capa de ingrediente
      const layer = document.createElement('img');
      layer.src = `/assets/${imageUrl}`;
      layer.alt = `Capa de ${id}`;
      layer.classList.add('absolute', 'w-full', 'h-full', 'rounded-full', 'object-cover');
      layer.dataset.layerId = `layer-${id}`;
      this.pizzaVisualAreaTarget.appendChild(layer);
    }
  }

  removePizzaVisual(type, id) {
    // ... (removePizzaVisual se mantiene igual)
    // Encuentra y elimina la capa del ingrediente
    const layer = this.pizzaVisualAreaTarget.querySelector(`[data-layer-id="layer-${id}"]`);
    if (layer) {
      layer.remove();
    }
  }

  calculateTotal() {
    let subtotal = 0;
    
    // 1. Sumar el precio de la Base (Masa) y el Precio del Tamaño
    subtotal += this.basePriceValue; // Precio de la Masa
    subtotal += this.selectedSizePriceValue; // NUEVO: Precio adicional del Tamaño

    // 2. Sumar el precio de los Ingredientes
    this.ingredientSelectionTargets.forEach(el => {
      const ingredientId = parseInt(el.dataset.ingredientId);
      if (this.selectedIngredientsValue.includes(ingredientId)) {
        subtotal += parseFloat(el.dataset.ingredientPrice);
      }
    });

    this.totalPriceValue = subtotal;
    this.updateTotalPriceDisplay();
  }
  
  updateTotalPriceDisplay() {
    this.totalPriceDisplayTarget.textContent = `$${this.totalPriceValue.toFixed(2)}`;
    // Habilitar/deshabilitar el botón si hay base Y TAMAÑO seleccionado
    this.orderButtonTarget.disabled = !this.selectedBaseIdValue || !this.selectedSizeNameValue;
    if (this.orderButtonTarget.disabled) {
      this.orderButtonTarget.classList.add('opacity-50', 'cursor-not-allowed');
    } else {
      this.orderButtonTarget.classList.remove('opacity-50', 'cursor-not-allowed');
    }
  }

  // --- Métodos de Estilo (Feedback Visual) ---
  
  highlightBaseSelection(selectedElement) {
    // ... (highlightBaseSelection se mantiene igual)
    // Quitar resaltado a todos
    this.baseSelectionTargets.forEach(el => el.classList.remove('border-green-500', 'border-2', 'bg-green-50'));
    // Añadir resaltado al seleccionado (si hay uno)
    if (this.selectedBaseIdValue) {
      selectedElement.classList.add('border-green-500', 'border-2', 'bg-green-50');
    }
  }

  highlightIngredientSelection(toggledElement) {
    // ... (highlightIngredientSelection se mantiene igual)
    toggledElement.classList.toggle('bg-yellow-200');
    toggledElement.classList.toggle('border-yellow-600');
    toggledElement.classList.toggle('shadow-lg');
  }

  // --- Método para Enviar Pedido (Fase 5) ---
  
  placeOrder(event) {
    event.preventDefault(); // Evitar comportamiento de formulario por defecto
    
    // NUEVA VALIDACIÓN: Debe seleccionar un tamaño Y una base
    if (!this.selectedBaseIdValue || !this.selectedSizeNameValue) {
      alert("Por favor, selecciona un tamaño y una base antes de realizar el pedido.");
      return;
    }
    
    // 1. Obtener el número de mesa (lo pediremos con un prompt por ahora)
    const tableNumber = prompt("Ingresa tu número de mesa (solo números):");
    
    if (!tableNumber || isNaN(tableNumber) || parseInt(tableNumber) <= 0) {
      alert("Número de mesa inválido.");
      return;
    }
    
    // 2. Construir el payload (la carga de datos)
    const payload = {
      order: {
        table_number: parseInt(tableNumber),
        total_price: this.totalPriceValue,
        base_id: this.selectedBaseIdValue,
        ingredient_ids: this.selectedIngredientsValue,
        size: this.selectedSizeNameValue // ¡NUEVO! ENVIAR EL TAMAÑO
      }
    };
    
    // 3. Enviar la solicitud a Rails (OrdersController#create)
    fetch('/orders', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify(payload)
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        alert(`🎉 ${data.message} ¡Tu pizza está en camino!`);
        // Opcional: Redirigir o limpiar la interfaz
        window.location.reload(); 
      } else {
        alert(`❌ Error al enviar el pedido: ${data.errors}`);
      }
    })
    .catch(error => {
      console.error('Error de red:', error);
      alert('Hubo un problema de conexión al enviar el pedido.');
    });
  }
}
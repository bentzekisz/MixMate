import Sortable from 'sortablejs';

// Initialize Sortable.js when Turbo loads a page
document.addEventListener('turbo:load', () => {
    // Initialize sortable for the sortable list
    const listElement = document.getElementById('sortable-grid');
    if (listElement) {
        new Sortable(listElement, {
            onEnd: function(evt) {
                const itemEl = evt.item;
                const id = itemEl.getAttribute('data-id');
                const newPosition = evt.newIndex + 1; // +1 because array index starts at 0

                // Send AJAX request to update position in your Rails app
                fetch(`/update_position`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
                    },
                    body: JSON.stringify({ id: id, new_position: newPosition })
                });
            }
        });
    }

    // Initialize sortable for the sortable grid
    const gridElement = document.getElementById('sortable-grid');
    if (gridElement) {
        new Sortable(gridElement, {
            animation: 150,
            ghostClass: 'sortable-ghost', // Optional: Add this class to the dragging item
            onEnd: function(evt) {
                // Logic for updating position in the grid
                // Implement similar logic as for the list or as per your need
                new Sortable(example7, {
                    swapThreshold: 0.73,
                    animation: 150
                });
            }
        });
    }
});
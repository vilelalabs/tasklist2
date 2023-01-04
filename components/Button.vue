<template>
    <button :style="{ backgroundColor: color }">
        <slot>
            {{ text }}
        </slot>
    </button>
</template>

<script>
export default {
    props: {
        color: {
            type: String,
            default: '#333'
        },
        text: {
            type: String,
            default: 'Button'
        }
    }
}
</script>

<style>
 
button {
    color: #ddd;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    padding: 8px 16px;
    transition: transform 0.2s ease-in-out;
}

button:hover {
    color: white;
}
</style>
